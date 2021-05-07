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

final class GithubSearchRouterImpl: GithubSearchRouter {
    
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func transitionToWebView(model: GithubSearchModel, animated: Bool) {
        guard let vc = UIStoryboard(name: WebViewController.className, bundle: nil).instantiateInitialViewController() as? WebViewController,
              let nav = viewController?.navigationController else {
            // 遷移できない場合はクラッシュさせる
            fatalError()
        }
        vc.inject(githubSearchModel: model)
        nav.pushViewController(vc, animated: animated)
    }
}
