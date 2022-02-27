//
//  Result.swift
//  MVPPractice
//
//  Created by 生田拓登 on 2022/02/19.
//

import Foundation

enum Result<T> {
    case success(T)
    case failture(Error)
}
