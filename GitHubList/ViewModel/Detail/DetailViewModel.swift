//
//  DetailViewModel.swift
//  GitHubList
//
//  Created by 矢守叡 on 2020/03/05.
//  Copyright © 2020 yamolean. All rights reserved.
//

import Foundation

protocol DetailViewModelInput {}
protocol DetailViewModelOutput {
    
}

protocol DetailViewModelType {
    var inputs: DetailViewModelInput { get }
    var outputs: DetailViewModelOutput { get }
}

final class DetailViewModel: DetailViewModelType, DetailViewModelInput, DetailViewModelOutput{
    var inputs: DetailViewModelInput { return self }
    var outputs: DetailViewModelOutput { return self }
    
    init(repository: GitHubEntity) {
    }
}
