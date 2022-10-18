//
//  MainTabbarViewController.swift
//  flickrApp
//
//  Created by Furkan Ademoğlu on 15.10.2022.
//

import UIKit

class MainTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = UINavigationController(rootViewController: PhotoListViewController(viewModel: PhotoListViewModel()))
        let vc2 = UINavigationController(rootViewController: SearchViewController(viewModel: SearchViewModel()))
                       
        vc1.tabBarItem.image = UIImage(named: "home")
        vc2.tabBarItem.image = UIImage(named: "search")

               
        vc1.title = "Home"
        vc2.title = "Search"
               
               
        tabBar.tintColor = .label
        setViewControllers([vc1,vc2], animated: true)
    }
}
