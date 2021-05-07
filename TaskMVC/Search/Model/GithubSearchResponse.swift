//
//  GithubSearchResponse.swift
//  TaskMVC
//
//  Created by 岩本康孝 on 2021/05/02.
//

import Foundation

struct GithubSearchResponse: Codable {
    
    let items: [Item]
    
    struct Item: Codable {
        let title: String
        
        enum CodingKeys: String, CodingKey {
            case title = "full_name"
        }
    }
}
