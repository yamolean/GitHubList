//
//  ViewController.swift
//  GitHubList
//
//  Created by 矢守叡 on 2020/02/29.
//  Copyright © 2020 yamolean. All rights reserved.
//

import UIKit
import RxSwift

final class ViewController: UIViewController {
    private let disposeBag = DisposeBag()
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var button: UIButton!
    
    struct Const {
        static let naviTitle = "Search Repositry"
    }
    
    override func viewDidLoad() {
        initViewValue()
        buttonValidation()
        buttonTapped()
    }
    
    private func initViewValue() {
        navigationItem.title = Const.naviTitle
        button.layer.cornerRadius = button.frame.height / 2
    }
    
    private func buttonValidation() {
        textField.rx.text.orEmpty.asObservable()
            .map { $0.count > 0 }
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    private func buttonTapped() {
        button.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let text = self?.textField.text else { return }
            let viewController = ListViewController.initViewController(with: ListViewModel(language: text))
            self?.navigationController?.pushViewController(viewController, animated: true)
        })
            .disposed(by: disposeBag)
    }
    
}
