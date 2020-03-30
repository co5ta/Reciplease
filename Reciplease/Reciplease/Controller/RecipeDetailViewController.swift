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
    
    /// Recipe data
    var recipe: Recipe?
    /// Scroll view which contains screen content
    var scrollView = UIScrollView()
    /// View which displays the recipe detail
    var recipeDetail = RecipeDetailView()
}

// MARK: - Lifecycle
extension RecipeDetailViewController {
    
    /// Called after the controller's view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        fetchData()
    }
}

// MARK: - Setup
extension RecipeDetailViewController {
    
    /// Sets up the views
    func setUpViews() {
        view.backgroundColor = .systemGray6
        setUpScrollView()
        setUpRecipeDetail()
    }
    
    /// Sets up the scroll view
    private func setUpScrollView() {
        //scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        setUpScrollViewConstraints()
    }
    
    /// Sets up the recipe detail view
    func setUpRecipeDetail() {
        scrollView.addSubview(recipeDetail)
        setUpRecipeDetailConstraints()
    }
}

// MARK: - Constraints
extension RecipeDetailViewController {
    
    /// Sets up the scroll view constraints
    func setUpScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    /// Sets up the recipe detail view
    func setUpRecipeDetailConstraints() {
        recipeDetail.translatesAutoresizingMaskIntoConstraints = false
        recipeDetail.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        recipeDetail.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        recipeDetail.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        recipeDetail.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        recipeDetail.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
}

// MARK: - Data
extension RecipeDetailViewController {
    
    /// Fetchs the data of the recipe
    func fetchData() {
        guard let recipe = recipe else { return }
        recipeDetail.fetchData(from: recipe)
    }
}
