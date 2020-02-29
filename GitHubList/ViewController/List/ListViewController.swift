//
//  ListViewController.swift
//  GitHubList
//
//  Created by 矢守叡 on 2020/02/29.
//  Copyright © 2020 yamolean. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension ListViewController: StoryboardInstantiable {
    
}

final class ListViewController: UIViewController {
    static func initViewController(with viewModel: ListViewModel) -> ListViewController {
        let view = ListViewController.instantiate()
        view.viewModel = viewModel
        return view
        
    }
    
    private let disposeBag = DisposeBag()
    private var viewModel: ListViewModelType!
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        indicator.hidesWhenStopped = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
}
