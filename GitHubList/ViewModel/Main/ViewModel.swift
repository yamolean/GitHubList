//
//  ViewModel.swift
//  GitHubList
//
//  Created by 矢守叡 on 2020/03/06.
//  Copyright © 2020 yamolean. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelInput {
    
}

protocol ViewModelOutput {
    
}

protocol ViewModelType {
    var inputs: ViewModelInput { get }
    var outputs: ViewModelOutput { get }
}

final class ViewModel: ViewModelType, ViewModelInput, ViewModelOutput {
    var inputs: ViewModelInput { return self }
    var outputs: ViewModelOutput { return self }
    
    private let disposeBag = DisposeBag()
    
}
