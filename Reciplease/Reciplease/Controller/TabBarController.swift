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

    /// Search Item
    let search = SearchNavigationController()
    /// Favorites item
    let favorites = FavoritesNavigationController()
    
    /** Init TabBbar features **/
    override func viewDidLoad() {
        super.viewDidLoad()
        search.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        favorites.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        viewControllers = [search, favorites]
    }

}
