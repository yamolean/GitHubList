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
    
    override func viewDidLoad() {
        
    }
    
    @IBAction private func buttonTapped(_ sender: UIButton) {
        let viewController = ListViewController.initViewController(with: ListViewModel(language: "RxSwift"))
        navigationController?.pushViewController(viewController, animated: true)
    }
}

