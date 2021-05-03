//
//  GithubSearchRouter.swift
//  TaskMVC
//
//  Created by 岩本康孝 on 2021/05/03.
//

import Foundation
import UIKit

protocol GithubSearchRouter {
    func transitionToWebView(model: GithubSearchModel, animated: Bool)
}

class GithubSearchRouterImpl: GithubSearchRouter {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func transitionToWebView(model: GithubSearchModel, animated: Bool) {
        guard let vc = UIStoryboard(name: WebViewController.className, bundle: nil).instantiateInitialViewController() as? WebViewController else { return }
        vc.inject(githubSearchModel: model)
        
        let nav = view?.navigationController
        nav?.pushViewController(vc, animated: animated)
    }
}
