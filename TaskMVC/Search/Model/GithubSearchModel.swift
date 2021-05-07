//
//  GithubSearchModel.swift
//  TaskMVC
//
//  Created by 岩本康孝 on 2021/05/02.
//

import Foundation

struct GithubSearchModel {
    let title: String
    var urlString: String {
        return "https://github.com/\(title)"
    }
}
