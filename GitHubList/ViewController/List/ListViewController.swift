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

extension ListViewController: StoryboardInstantiable {}

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
        
        //navigationBarタイトル,output
        viewModel.outputs.navigationBarTitle
            .observeOn(MainScheduler.instance)
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        //tableViewのItem,output
        viewModel.outputs.githubRepositories
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items) { _, _, element in
                let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "subtitle")
                cell.textLabel?.text = "\(element.fullName)"
                cell.detailTextLabel?.textColor = UIColor.lightGray
                cell.detailTextLabel?.text = "\(element.description)"
                return cell
        }
        .disposed(by: disposeBag)
        
        //TODO: タップ時の処理
        
        //loadingをindicatorに反映,output
        viewModel.outputs.isloading
            .observeOn(MainScheduler.instance)
            .bind(to: indicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        //loadingをtableViewに反映,output
        viewModel.outputs.isloading
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: $0 ? 50 : 0, right: 0)
            })
            .disposed(by: disposeBag)
        
        //error処理,output
        viewModel.outputs.error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                let ac = UIAlertController(title: "Error \($0)", message: nil, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(ac, animated: true)
            })
            .disposed(by: disposeBag)
        
        //初回トリガーでVMに通知,input
        viewModel.inputs.fetchTrigger.onNext(())
        
        //tableViewにreachしたらVMに通知,input
        tableView.rx.reachedBottom.asObservable()
            .bind(to: viewModel.inputs.reachButtomAction)
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
}
