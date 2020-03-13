//
//  TabBarController.swift
//  Reciplease
//
//  Created by co5ta on 13/03/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let search = SearchNavigationController()
        search.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        let favorites = FavoritesNavigationController()
        favorites.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        
        viewControllers = [search, favorites]
    }

}
