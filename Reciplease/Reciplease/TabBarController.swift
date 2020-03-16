//
//  TabBarController.swift
//  Reciplease
//
//  Created by co5ta on 13/03/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import UIKit

/// Main Tab Bar of the application
class TabBarController: UITabBarController {

    /** Init TabBbar features **/
    override func viewDidLoad() {
        super.viewDidLoad()

        /// Tab Bar colors
        tabBar.barTintColor = UIColor(red: 0.097, green: 0.759, blue: 0.934, alpha: 1)
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = #colorLiteral(red: 0.3424130082, green: 0.4180869162, blue: 0.5095996857, alpha: 1)
        
        /// Search Item
        let search = SearchNavigationController()
        search.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)

        /// Favorites item
        let favorites = FavoritesNavigationController()
        favorites.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        
        viewControllers = [search, favorites]
    }

}
