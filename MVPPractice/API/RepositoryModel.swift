//
//  RepositoryModel.swift
//  MVPPractice
//
//  Created by 生田拓登 on 2022/02/18.
//

import Foundation

struct FetchRepositories: Codable {

    let items: [Repository]
}

struct Repository: Codable {

    let id: Int
    let fullName: String
    let language: String?
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let owner: Owner
}

struct Owner: Codable {

    let avatarUrl: String
}
