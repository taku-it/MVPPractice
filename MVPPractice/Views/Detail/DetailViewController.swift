//
//  DetailViewController.swift
//  MVPPractice
//
//  Created by 生田拓登 on 2022/02/18.
//

import UIKit
import SDWebImage

final class DetailViewController: UIViewController {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var issuesLabel: UILabel!
    
    private var repository: Repository!
    
    func inject(repository: Repository) {
        self.repository = repository
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure(repository: repository)
    }
    
    private func configure(repository: Repository) {
        languageLabel.text = "Written in \(repository.language ?? "")"
        starsLabel.text = "\(repository.stargazersCount) stars"
        watchersLabel.text = "\(repository.watchersCount) watchers"
        forksLabel.text = "\(repository.forksCount) forks"
        issuesLabel.text = "\(repository.openIssuesCount) issues"
        titleLabel.text = repository.fullName
        iconImageView.sd_setImage(with: URL(string: repository.owner.avatarUrl), completed: nil)
    }

}
