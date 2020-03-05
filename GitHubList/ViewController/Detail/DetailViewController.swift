//
//  DetailViewController.swift
//  GitHubList
//
//  Created by 矢守叡 on 2020/03/05.
//  Copyright © 2020 yamolean. All rights reserved.
//

import UIKit
import RxSwift
import WebKit
import RxWebKit

extension DetailViewController: StoryboardInstantiable {}

final class DetailViewController: UIViewController {
    static func make (with viewModel: DetailViewModel) -> DetailViewController {
        let view = DetailViewController.instantiate()
        view.viewModel = viewModel
        return view
    }
    
    private let disposeBag = DisposeBag()
    private var viewModel: DetailViewModelType!
    
    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        //output
        viewModel.outputs.navigationTitle
            .observeOn(MainScheduler.asyncInstance)
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        //VCで完結
        webView.rx.loading
            .observeOn(MainScheduler.asyncInstance)
            .bind(to: indicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
    }
}
