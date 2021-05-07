//
//  MVCViewController.swift
//  TaskMVC
//
//  Created by  on 2021/3/10.
//

import UIKit

/*
 Modelがありません
 データを取得するソースがコントローラに書かれています
 強制アンラップがあります
 パラメータがカプセル化されていません
 次の画面にモデルを渡していません
 画面遷移の処理が直接ViewControllerに書かれています
 修正してMVCにしてください
*/
final class MVCSearchViewController: UIViewController {
    
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchButton: UIButton! {
        didSet {
            searchButton.addTarget(self, action: #selector(tapSearchButton(_sender:)), for: .touchUpInside)
        }
    }
    
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib.init(nibName: MVCTableViewCell.className, bundle: nil), forCellReuseIdentifier: MVCTableViewCell.className)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    private var repository: GithubSearchRepository?
    private var router: GithubSearchRouter?
    private var githubSearchModels = [GithubSearchModel]()
    
    func inject(repository: GithubSearchRepository, router: GithubSearchRouter) {
        self.repository = repository
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        indicator.isHidden = true
    }
    
    @objc private func tapSearchButton(_sender: UIResponder) {
        indicator.isHidden = false
        tableView.isHidden = true

        repository?.request(searchText: searchTextField.text) { [weak self] result in
            switch result {
            case .success(let models):
                
                self?.githubSearchModels = models
            case .failure(_):
                self?.githubSearchModels = []
            }
            DispatchQueue.main.async {
                self?.indicator.isHidden = true
                self?.tableView.isHidden = false
                self?.tableView.reloadData()
            }
        }
    }
}

extension MVCSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        router?.transitionToWebView(model: githubSearchModels[indexPath.row], animated: true)
    }
}

extension MVCSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        githubSearchModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MVCTableViewCell.className) as? MVCTableViewCell else {
            fatalError()
        }
        cell.configure(model: githubSearchModels[indexPath.row])
        return cell
    }
}
