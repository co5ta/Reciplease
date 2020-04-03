//
//  FavoritesNavigationController.swift
//  Reciplease
//
//  Created by co5ta on 13/03/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import UIKit

/// Controller of the navigation in  favorites  tab
class FavoritesNavigationController: UINavigationController {

    /// Root view controller
    let favorites = SearchResultViewController()
    
    /// Called after the controller's view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers.append(favorites)
        RecipeEntity.list = RecipeEntity.loadAll()
    }

}
