//
//  SearchNavigationController.swift
//  Reciplease
//
//  Created by co5ta on 13/03/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import UIKit

/// Navigation of the Search tab
class SearchNavigationController: UINavigationController {

    /** Init Search Navigation features **/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Navigation Bar Appareance
        navigationBar.barTintColor = UIColor(red: 0.097, green: 0.759, blue: 0.934, alpha: 1)
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        /// ViewControllers in the navigation
        let searchFormViewController = SearchFormViewController()
        viewControllers = [searchFormViewController]
    }

}
