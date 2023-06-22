//
//  MainTabBarController.swift
//  PodcastApp
//
//  Created by Asude Nisa Tıraş on 22.06.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        
    }
}
extension MainTabBarController{
    private func setup(){
        viewControllers = [
            createViewController(rootViewController: FavoriteViewController(), title: "Favorites", imageName: "play.fill"),
            createViewController(rootViewController: SearchViewController(), title: "Search", imageName: "magnifyingglass"),
            createViewController(rootViewController: DownloadViewController(), title: "Downloads", imageName: "square.stack.fill")
        ]
    }
    private func createViewController(rootViewController: UIViewController, title: String, imageName:String) -> UINavigationController {
        rootViewController.title = title
        let apperance = UINavigationBarAppearance()
        apperance.configureWithDefaultBackground()
        let controller = UINavigationController(rootViewController: rootViewController)
        controller.navigationBar.prefersLargeTitles = true
        controller.navigationBar.standardAppearance = apperance
        controller.navigationBar.compactAppearance = apperance
        controller.navigationBar.scrollEdgeAppearance = apperance
        controller.navigationBar.compactScrollEdgeAppearance = apperance
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage(systemName: imageName)
        return controller
    }
}
