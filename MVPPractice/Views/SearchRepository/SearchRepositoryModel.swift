//
//  SearchRepositoryModel.swift
//  MVPPractice
//
//  Created by 生田拓登 on 2022/02/18.
//

import Foundation

protocol SearchRepositoryModelInput {
    var task: URLSessionTask? { get }
    var repositories: [Repository] { get }
    func fetchRepository(query: String, completion: @escaping ([Repository]) -> ())
    func cancel()
}

final class SearchRepositoryModel: SearchRepositoryModelInput {
    var task: URLSessionTask?
    var repositories: [Repository] = []
    
    func fetchRepository(query: String, completion: @escaping ([Repository]) -> ()) {
        
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        let url = URL(string: "https://api.github.com/search/repositories?q=\(encodedQuery ?? "")")!
        let request = URLRequest(url: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, _, error) in
            guard let data = data else { return }
            
            do {
                let repository: FetchRepositories = try decoder.decode(FetchRepositories.self, from: data)
                self?.repositories = repository.items
                completion(self!.repositories)
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
    
}
