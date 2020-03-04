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
    private let disposeBag = DisposeBag()
    //Int入れて,[GitHubEntity]をonNextする
    private let searchAction: Action<Int, [GitHubEntity]>
    //ViewModel内でGitHubレポジトリデータを保持する
    private let response = BehaviorRelay<[GitHubEntity]>(value: [])

    var inputs: ListViewModelInput { return self }
    var outputs: ListViewModelOutput { return self }
    
    //input
    let fetchTrigger: PublishSubject<Void>
    var reachButtomAction: PublishSubject<Void>
    
    //output
    let githubRepositories: Observable<[GitHubEntity]>
    let navigationBarTitle: Observable<String>
    let isloading: Observable<Bool>
    let error: Observable<NSError>

    init(language: String) {
        //navibartitleを公開
        navigationBarTitle = Observable.just("\(language)Repositories")
        //inが入るとlanguageとpageを引数に[GitHubEntity]をonNext
        searchAction = Action { page in
            return Session.shared.rx.response(GitHubApi.SearchRequest(language: language, page: page))
        }
        //viewmodelで保有されているレポジトリデータを外部に公開
        githubRepositories = response.asObservable()
        //Actionライブラリが持っているLoading状態を外部に公開
        isloading = searchAction.executing.startWith(false)
        //Actionライブラリが持っているerror状態を外部に公開
        error = searchAction.errors.map { _ in NSError(domain: "Network Error", code: 0, userInfo: nil) }
    }
}
