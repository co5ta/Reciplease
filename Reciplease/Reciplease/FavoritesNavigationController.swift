//
//  FavoritesNavigationController.swift
//  Reciplease
//
//  Created by co5ta on 13/03/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import UIKit

class FavoritesNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let favoritesTableViewController = FavoritesTableViewController()
        viewControllers = [favoritesTableViewController]
    }

}
