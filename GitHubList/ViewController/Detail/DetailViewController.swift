//
//  DetailViewController.swift
//  GitHubList
//
//  Created by 矢守叡 on 2020/03/05.
//  Copyright © 2020 yamolean. All rights reserved.
//

import UIKit

extension DetailViewController: StoryboardInstantiable {}

final class DetailViewController: UIViewController {
    static func make (with viewModel: DetailViewModel) -> DetailViewController {
        let view = DetailViewController.instantiate()
        return view
    }
    
    @IBOutlet private weak var webView: UIWebView!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    
}
