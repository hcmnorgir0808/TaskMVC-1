//
//  GithubSearchRepository.swift
//  TaskMVC
//
//  Created by 岩本康孝 on 2021/05/02.
//

import Foundation

protocol GithubSearchRepository {
    func request(searchText: String, completion: @escaping ([GithubSearchModel]) -> Void)
}

class GithubSearchRepositoryImpl: GithubSearchRepository {
    func request(searchText: String, completion: @escaping ([GithubSearchModel]) -> Void) {
        guard
            let url = URL(string: "https://api.github.com/search/repositories?q=\(searchText)&sort=stars") else { completion([])
            return
        }
        
        let task: URLSessionTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(GithubSearchResponse.self, from: data)
                let models = response.items.map { GithubSearchModel(title: $0.title) }
                completion(models)
            } catch {
                completion([])
            }
        }
        task.resume()
    }
}
