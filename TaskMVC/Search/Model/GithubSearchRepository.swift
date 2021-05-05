//
//  GithubSearchRepository.swift
//  TaskMVC
//
//  Created by 岩本康孝 on 2021/05/02.
//

import Foundation

protocol GithubSearchRepository {
    func request(searchText: String?, completion: @escaping (Result<[GithubSearchModel], GithubSearchError>) -> Void)
}

final class GithubSearchRepositoryImpl: GithubSearchRepository {
    func request(searchText: String?, completion: @escaping (Result<[GithubSearchModel], GithubSearchError>) -> Void) {
        guard
            // invalidUrl
            let searchText = searchText,
            !searchText.isEmpty,
            let url = URL(string: "https://api.github.com/search/repositories?q=\(searchText)&sort=stars") else { completion(.failure(.invalidUrl))
            return
        }
        
        let task: URLSessionTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                // NotFound
                completion(.failure(.notFound))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(GithubSearchResponse.self, from: data)
                let models = response.items.map { GithubSearchModel(title: $0.title) }
                completion(.success(models))
            } catch {
                // parseError
                completion(.failure(.parserError))
            }
        }
        task.resume()
    }
}
