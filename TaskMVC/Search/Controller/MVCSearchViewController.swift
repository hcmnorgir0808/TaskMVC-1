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
final class MVCSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    private var githubSearchModels = [GithubSearchModel]()
    
    func inject(repository: GithubSearchRepository) {
        self.repository = repository
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        indicator.isHidden = true
    }
    
    @objc private func tapSearchButton(_sender: UIResponder) {
        guard let searchText = searchTextField.text, !searchText.isEmpty else { return }
        
        indicator.isHidden = false
        tableView.isHidden = true

        repository?.request(searchText: searchText) { [weak self] githubSearchModels in
            
            guard let self = self else { return }
            self.githubSearchModels = githubSearchModels
            
            DispatchQueue.main.async {
                self.indicator.isHidden = true
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = UIStoryboard.init(name: "Web", bundle: nil).instantiateInitialViewController() as! WebViewController
        vc.urlStr = githubSearchModels[indexPath.item].urlString
        
        let nav = self.navigationController
        nav?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        githubSearchModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MVCTableViewCell.className) as? MVCTableViewCell else {
            fatalError()
        }
        cell.titleLabel.text = githubSearchModels[indexPath.item].title
        cell.urlLabel.text = githubSearchModels[indexPath.item].urlString
        return cell
        
    }
}
