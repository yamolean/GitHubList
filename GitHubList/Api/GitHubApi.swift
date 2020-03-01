//
//  GitHubApi.swift
//  GitHubList
//
//  Created by 矢守叡 on 2020/03/01.
//  Copyright © 2020 yamolean. All rights reserved.
//

import Foundation
import APIKit

final class GitHubApi {
    struct SearchRequest: GitHubRequest {
        let language: String
        let page: Int
        
        init(language: String, page: Int) {
            self.language = language
            self.page = page
        }
        
        let method: HTTPMethod = .get
        let path: String = "/search/repositories"
        
        var parameters: Any? {
            var params = [String: Any]()
            params["q"] = language
            params["sort"] = "stars"
            params["page"] = "\(page)"
            return params
        }
        
        func response(from object: Any, urlResponse: HTTPURLResponse) throws -> [GitHubEntity] {
            guard let data = object as? Data else {
                throw ResponseError.unexpectedObject(object)
            }
            let res = try JSONDecoder().decode(SearchRepositoriesResponse.self, from: data)
            return res.items
        }
    }
}
