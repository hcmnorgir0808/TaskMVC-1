//
//  AppDelegate.swift
//  TaskMVC
//
//  Created by sakiyamaK on 2021/03/10.
//

import UIKit

/*
 ハードコーディングがあります
 強制アンラップがあります
 */

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        guard let vc = UIStoryboard(name: MVCSearchViewController.className, bundle: nil).instantiateInitialViewController() as? MVCSearchViewController else {
            return false
        }
        
        let router = GithubSearchRouterImpl(view: vc)
        
        let repository = GithubSearchRepositoryImpl()
        vc.inject(repository: repository, router: router)

        let nav = UINavigationController(rootViewController: vc)
        window.rootViewController = nav
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
