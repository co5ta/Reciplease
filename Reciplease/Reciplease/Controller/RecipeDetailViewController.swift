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
    /// The state favorite or not of the recipe
    var isFavorite = false
}

// MARK: - Lifecycle
extension RecipeDetailViewController {
    
    /// Called after the controller's view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpData()
    }
}

// MARK: - Setup
extension RecipeDetailViewController {
    
    /// Sets up the views
    func setUpViews() {
        view.backgroundColor = .systemGray6
        setUpScrollView()
        setUpRecipeDetail()
        setUpFavoriteState()
        setupFavoriteButton()
    }
    
    /// Sets favorite state as true if the recipe is in favorites
    func setUpFavoriteState() {
        guard let recipe = recipe else { return }
        guard let _ = Recipe.favorites.first(where: { $0 == recipe }) else { return }
        isFavorite = true
    }
    
    /// Sets up the favorite button
    private func setupFavoriteButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: isFavorite ? "star.fill" : "star"),
            style: .plain,
            target: self,
            action: #selector(toggleFavorite))
    }
    
    /// Sets up the scroll view
    private func setUpScrollView() {
        view.addSubview(scrollView)
        setUpScrollViewConstraints()
    }
    
    /// Sets up the recipe detail view
    func setUpRecipeDetail() {
        scrollView.addSubview(recipeDetail)
        setUpRecipeDetailConstraints()
        recipeDetail.getDirectionsButton.addTarget(
            self,
            action: #selector(goToRecipeDirections),
            for: .touchUpInside)
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

// MARK: - Actions
extension RecipeDetailViewController {
    
    /// Toggles the favorite state of the recipe
    @objc
    private func toggleFavorite() {
        isFavorite.toggle()
        setupFavoriteButton()
        isFavorite ? addToFavorites() : deleteFromFavorites()
        Recipe.favoritesListEdited = true
    }
    
    /// Adds the recipe to the favorites
    private func addToFavorites() {
        guard let recipe = recipe else { return }
        RecipeEntity.save(recipe: recipe)
        Recipe.favorites.append(recipe)
    }
    
    /// Removes the recipe from the favorites
    private func deleteFromFavorites() {
        guard let recipe = recipe else { return }
        RecipeEntity.delete(recipe: recipe)
        Recipe.favorites = Recipe.favorites.filter({ $0 != recipe })
    }
}

// MARK: - Data
extension RecipeDetailViewController {
    
    /// Fetchs the data of the recipe
    func setUpData() {
        guard let recipe = recipe else { return }
        recipeDetail.recipe = recipe
    }
}

// MARK: - Navigation
extension RecipeDetailViewController {
    
    /// Calls the recipe directions view
    @objc
    private func goToRecipeDirections() {
        guard let recipe = recipe, let recipeURL = URL(string: recipe.url) else { return }
        let recipeDirectionsVC = RecipeDirectionsViewController()
        recipeDirectionsVC.recipeURL = recipeURL
        navigationController?.pushViewController(recipeDirectionsVC, animated: true)
    }
}