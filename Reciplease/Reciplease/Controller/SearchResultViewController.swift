//
//  SearchResultViewController.swift
//  Reciplease
//
//  Created by co5ta on 17/03/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import UIKit

/// Controller of the search result screen
class SearchResultViewController: UIViewController {
    
    /// Ingredients to search in recipes
    var ingredients: String?
}


// MARK: - Methods
extension SearchResultViewController {
    
    /** Setup the views */
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        getRecipes()
    }
    
    /** Launch the recipe search */
    func getRecipes() {
        guard let ingredients = ingredients else { return }
        RecipeService.shared.getRecipes(ingredients: ingredients) { (response) in
            switch(response) {
            case .success:
                debugPrint(response)
            case .failure:
                print("no result")
            }
        }
    }
    
}
