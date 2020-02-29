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

//input:初回トリガー,ページング
//output:セルのデータ,navigationBarタイトル,

protocol ListViewModelInput {
    
}

protocol ListViewModelOutput {
    
}

protocol ListViewModelType {
    var inputs: ListViewModelInput { get }
    var outputs: ListViewModelOutput { get }
}

final class ListViewModel: ListViewModelType, ListViewModelInput, ListViewModelOutput {
    var inputs: ListViewModelInput { return self }
    var outputs: ListViewModelOutput { return self }
    
    
}
