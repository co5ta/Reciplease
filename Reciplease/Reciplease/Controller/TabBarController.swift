//
//  TabBarController.swift
//  Reciplease
//
//  Created by co5ta on 13/03/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import UIKit
import Nuke

/// Main Tab Bar of the application
class TabBarController: UITabBarController {

    /// Search Item
    let search = SearchNavigationController()
    /// Favorites item
    let favorites = FavoritesNavigationController()
    
    /// Called after the controller's view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBarItems()
        setUpRecipeImageCache()
    }

    /// Sets up tab bar items
    private func setUpTabBarItems() {
        search.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        favorites.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        viewControllers = [search, favorites]
    }
    
    /// Sets up cache for recipes images
    private func setUpRecipeImageCache() {
        DataLoader.sharedUrlCache.diskCapacity = 0
        let pipeline = ImagePipeline {
            guard let bundleIdentifier = Bundle.main.bundleIdentifier else { return }
            guard let dataCache = try? DataCache(name: bundleIdentifier) else { return }
            $0.dataCache = dataCache
        }
        ImagePipeline.shared = pipeline
    }
}
