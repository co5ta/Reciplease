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
        
        /// Search Item
        let search = SearchNavigationController()
        search.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)

        /// Favorites item
        let favorites = FavoritesNavigationController()
        favorites.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        
        viewControllers = [search, favorites]
    }

}
