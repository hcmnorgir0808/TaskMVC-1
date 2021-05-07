//
//  WebViewController.swift
//  TaskMVC
//
//  Created by  on 2021/3/10.
//

import UIKit
import WebKit

/*
 カプセル化されてません
 前の画面からModelを受け取っていません
 強制アンラップがあります
 */
final class WebViewController: UIViewController {
    
    @IBOutlet private weak var webView: WKWebView!
    
    private var githubSearchModel: GithubSearchModel?
    
    func inject(githubSearchModel: GithubSearchModel) {
        self.githubSearchModel = githubSearchModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard
            let urlString = githubSearchModel?.urlString,
            let url = URL(string: urlString) else { return }
        
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
}
