//
//  SearchRepositoryViewController.swift
//  MVPPractice
//
//  Created by 生田拓登 on 2022/02/18.
//

import UIKit

final class SearchRepositoryViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var presenter: SearchRepositoryPresenterInput!
    func inject(presenter: SearchRepositoryPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
}

extension SearchRepositoryViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.didTapSearchButton(text: searchBar.text)
    }
}

extension SearchRepositoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRow(at: indexPath)
    }
}

extension SearchRepositoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRepo
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = presenter.repository(forRow: indexPath.row)?.fullName
        cell.detailTextLabel?.text = presenter.repository(forRow: indexPath.row)?.language
        return cell
    }
}

extension SearchRepositoryViewController: SearchRepositoryPresenterOutput {
    func updateRepository(repositories: [Repository]) {
        tableView.reloadData()
    }
    
    func transitionToDetail(repository: Repository) {
        let detailVC = UIStoryboard(name: "Detail", bundle: nil).instantiateInitialViewController() as! DetailViewController
        detailVC.inject(repository: repository)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
