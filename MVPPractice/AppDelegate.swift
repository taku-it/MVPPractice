//
//  AppDelegate.swift
//  MVPPractice
//
//  Created by 生田拓登 on 2022/02/18.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let searchRepositoryVC = UIStoryboard(name: "SearchRepository", bundle: nil).instantiateInitialViewController() as! SearchRepositoryViewController
        let navigationController = UINavigationController(rootViewController: searchRepositoryVC)
        
        let model = SearchRepositoryModel()
        let presenter = SearchRepositoryPresenter(view: searchRepositoryVC, model: model)
        searchRepositoryVC.inject(presenter: presenter)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

}

