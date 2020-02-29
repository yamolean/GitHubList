//
//  GitHubEntity.swift
//  GitHubList
//
//  Created by 矢守叡 on 2020/02/29.
//  Copyright © 2020 yamolean. All rights reserved.
//

import Foundation

struct GitHubEntity: Decodable {
    let id: Int
    let fullName: String
    let description: String
    let stargazersCount: Int
    let url: URL

    private enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case description
        case stargazersCount = "stargazers_count"
        case url = "html_url"
    }
}

struct SearchRepositoriesResponse: Decodable {
    let items: [GitHubEntity]
}

