//
//  SearchRepositoryPresenter.swift
//  MVPPractice
//
//  Created by 生田拓登 on 2022/02/18.
//

import Foundation

protocol SearchRepositoryPresenterInput {
    var numberOfRepo: Int { get }
    func repository(forRow row:Int) -> Repository?
    func didSelectRow(at indexPath: IndexPath)
    func didTapSearchButton(text: String?)
}

protocol SearchRepositoryPresenterOutput: AnyObject {
    func updateRepository(repositories: [Repository])
    func transitionToDetail(repository: Repository)
}

final class SearchRepositoryPresenter: SearchRepositoryPresenterInput {
    
    private weak var view: SearchRepositoryPresenterOutput!
    private var model: SearchRepositoryModelInput
    
    init(view: SearchRepositoryPresenterOutput, model: SearchRepositoryModelInput) {
        self.view = view
        self.model = model
    }
    
    var numberOfRepo: Int {
        return model.repositories.count
    }
    
    func repository(forRow row: Int) -> Repository? {
        guard row < model.repositories.count else { return nil }
        return model.repositories[row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard let repository = repository(forRow: indexPath.row) else { return }
        view.transitionToDetail(repository: repository)
    }
    
    func didTapSearchButton(text: String?) {
        guard let query = text else { return }
        guard !query.isEmpty else { return }
        
        model.fetchRepository(query: query) { [weak self] repositories in
            DispatchQueue.main.async {
                self?.view.updateRepository(repositories: repositories)
            }
        }
    }
    
    
}
