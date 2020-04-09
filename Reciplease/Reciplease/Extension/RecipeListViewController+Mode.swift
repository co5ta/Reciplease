//
//  RecipeListViewController+Mode.swift
//  Reciplease
//
//  Created by co5ta on 09/04/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import Foundation

extension RecipeListViewController {
    
    /// Indicates the context of the view controller
    enum Mode {
        /// The mode that displays the recipes from the search result
        case search
        /// The mode that displays the recipes saved as favorites
        case favorites
        
        /// Mode title
        var title: String {
            switch self {
            case .search:
                return "Search"
            case .favorites:
                return "Favorites"
            }
        }
    }
}
