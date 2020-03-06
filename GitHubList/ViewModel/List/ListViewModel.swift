//
//  ListViewModel.swift
//  GitHubList
//
//  Created by 矢守叡 on 2020/02/29.
//  Copyright © 2020 yamolean. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action
import APIKit

//input:(アクション)初回トリガー,ページング
//output:(データ)セルのデータ,navigationBarタイトル (状態)ローディング,エラー
//1.fetchされる、pageを引数にしてAPI叩く,naviTitle設置
//2.ページングしたら(APIが叩いてレスポンスが返って来たら)pageをインクリメント
//3.searchActionの結果(elements)をtableViewに反映
//4.searchActionの結果(error)をAlertにして出す
//5.loading中にindicator回す、tableviewを少し持ち上げる

protocol ListViewModelInput {
    var fetchTrigger: PublishSubject<Void> { get }
    var reachButtomAction: PublishSubject<Void> { get }
}

protocol ListViewModelOutput {
    var githubRepositories: Observable<[GitHubEntity]> { get }
    var navigationBarTitle: Observable<String> { get }
    var isloading: Observable<Bool> { get }
    var error: Observable<NSError> { get }
}

protocol ListViewModelType {
    var inputs: ListViewModelInput { get }
    var outputs: ListViewModelOutput { get }
}

final class ListViewModel: ListViewModelType, ListViewModelInput, ListViewModelOutput {
    var inputs: ListViewModelInput { return self }
    var outputs: ListViewModelOutput { return self }
    private let disposeBag = DisposeBag()
    
   //ViewModel内で使うやつ
    //Int入れて,[GitHubEntity]をonNextする
    private let searchAction: Action<Int, [GitHubEntity]>
    //直近のGitHubレポジトリデータを保持する
    private let response = BehaviorRelay<[GitHubEntity]>(value: [])
    //直近のpageを保持,初期値1
    private let page = BehaviorRelay<Int>(value: 1)
    
    //input
    let fetchTrigger = PublishSubject<Void>()
    var reachButtomAction = PublishSubject<Void>()
    
    //output
    let githubRepositories: Observable<[GitHubEntity]>
    let navigationBarTitle: Observable<String>
    let isloading: Observable<Bool>
    let error: Observable<NSError>

    init(language: String) {
        //navibartitleを流す,output
        navigationBarTitle = Observable.just("Result: \(language)")
        
        //pageを入れてAPI叩いて[GitHubEntity]をonNext
        searchAction = Action { page in
            return Session.shared.rx.response(GitHubApi.SearchRequest(language: language, page: page))
        }
        //viewmodelで保有されているレポジトリデータを流す,output
        githubRepositories = response.asObservable()
        
        //Actionライブラリが持っているLoading状態を流す,output
        isloading = searchAction.executing.startWith(false)
        
        //Actionライブラリが持っているerror状態を流す,output
        error = searchAction.errors.map { _ in
            NSError(domain: "Network Error", code: 0, userInfo: nil
            ) }
        
        //Actionライブラリが持っている[GitHubEntity]型のelements
        searchAction.elements
            .withLatestFrom(response) { ($0, $1) }
            .map { $0.1 + $0.0 } //前回のレスポンス情報と合成
            .bind(to: response)
            .disposed(by: disposeBag)
        
        // APIレスポンスを購読し、次回のAPIリクエストするときのために、page番号をインクリメント
        searchAction.elements
            .withLatestFrom(page)
            .map { $0 + 1 }
            .bind(to: page)
            .disposed(by: disposeBag)
        
        // 初回データ取得イベントトリガーを購読し,APIリクエスト
        fetchTrigger
            .withLatestFrom(page)
            .bind(to: searchAction.inputs)
            .disposed(by: disposeBag)
        
        // スクロール時に追加データ取得イベントトリガーを購読し、APIリクエスト
        reachButtomAction
            .withLatestFrom(isloading)  //API通信中はリクエストを送らないために、Loadingフラグをストリームに取り込む
            .filter { !$0 } // 取り込んだ通信中フラグでフィルター,フラグを判定し、trueの場合は次へ行き、false の場合は イベント通知はここで終了
            .withLatestFrom(page) //APIの使用上リクエスト制限があるので、 page番号でフィルターをかける
            .filter { $0 < 5 } //trueの場合は次へ行き、false の場合は イベント通知はここで終了
            .bind(to: searchAction.inputs)
            .disposed(by: disposeBag)
    }
    //init()の最後
}
