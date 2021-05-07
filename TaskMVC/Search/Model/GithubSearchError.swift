//
//  GithubSearchError.swift
//  TaskMVC
//
//  Created by 岩本康孝 on 2021/05/05.
//

import Foundation

enum GithubSearchError: Error {
    case invalidUrl
    case notFound
    case parserError
}
