//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by co5ta on 26/03/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import UIKit

/// Controller of the recipe detail screen
class RecipeDetailViewController: UIViewController {
    
    /// Recipe object which contains the details to display
    var recipe: Recipe?
    /// View which displays the main informations about  the recipe
    var recipePreview = RecipePreview()
}

// MARK: - Lifecycle
extension RecipeDetailViewController {
    
    /// Called after the controller's view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
}

// MARK: - Setup
extension RecipeDetailViewController {
    
    /// Sets up the views
    func setUpViews() {
        view.backgroundColor = .white
        view.addSubview(recipePreview)
        setUpConstraints()
        
        guard let recipe = recipe else { return }
        recipePreview.configure(with: recipe)
    }
}

// MARK: - Constraints
extension RecipeDetailViewController {
    
    /// Sets up the constraints
    func setUpConstraints() {
        recipePreview.translatesAutoresizingMaskIntoConstraints = false
        recipePreview.heightAnchor.constraint(equalToConstant: Config.recipePreviewHeight).isActive = true
        recipePreview.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor).isActive = true
        recipePreview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        recipePreview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
