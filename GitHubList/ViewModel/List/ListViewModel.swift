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

//input:(アクション)初回トリガー,ページング
//output:(データ)セルのデータ,navigationBarタイトル (状態)ローディング,エラー

//protocol ListViewModelInput {
//    var fetchTrigger: PublishSubject<Void> { get }
//    var reachButtomAction: PublishSubject<Void> { get }
//}
//
//protocol ListViewModelOutput {
//    var githubRepositories: Observable<[GitHubEntity]> { get }
//    var navigationBarTitle: Observable<String> { get }
//    var isloading: Observable<Bool> { get }
//    var error: Observable<NSError> { get }
//}
//
//protocol ListViewModelType {
//    var inputs: ListViewModelInput { get }
//    var outputs: ListViewModelOutput { get }
//}
//
//final class ListViewModel: ListViewModelType, ListViewModelInput, ListViewModelOutput {
//    private let disposeBag = DisposeBag()
//    private let searchAction:
//    
//    var inputs: ListViewModelInput { return self }
//    var outputs: ListViewModelOutput { return self }
//    //input
//    var fetchTrigger: PublishSubject<Void>
//    var reachButtomAction: PublishSubject<Void>
//    //output
//    var githubRepositories: Observable<[GitHubEntity]>
//    var navigationBarTitle: Observable<String>
//    var isloading: Observable<Bool>
//    var error: Observable<NSError>
//    
//    
//    
//    
//}
