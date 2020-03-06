//
//  DetailViewModel.swift
//  GitHubList
//
//  Created by 矢守叡 on 2020/03/05.
//  Copyright © 2020 yamolean. All rights reserved.
//

import Foundation
import RxSwift

protocol DetailViewModelInput {}
protocol DetailViewModelOutput {
    var navigationTitle: Observable<String> { get }
    var request: URLRequest { get }
}

protocol DetailViewModelType {
    var inputs: DetailViewModelInput { get }
    var outputs: DetailViewModelOutput { get }
}

final class DetailViewModel: DetailViewModelType, DetailViewModelInput, DetailViewModelOutput{
    var inputs: DetailViewModelInput { return self }
    var outputs: DetailViewModelOutput { return self }
    
    //output
    let navigationTitle: Observable<String>
    let request: URLRequest
    
    init(repository: GitHubEntity) {
        navigationTitle = Observable.just("\(repository.fullName)")
        request = URLRequest(url: repository.url)
    }
}
