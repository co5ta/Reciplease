//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by co5ta on 26/03/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import UIKit
import SafariServices

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
        view.backgroundColor = .secondarySystemBackground
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
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    /// Sets up the recipe detail view
    func setUpRecipeDetailConstraints() {
        recipeDetail.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeDetail.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            recipeDetail.topAnchor.constraint(equalTo: scrollView.topAnchor),
            recipeDetail.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            recipeDetail.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            recipeDetail.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
}

// MARK: - Actions
extension RecipeDetailViewController {
    
    /// Toggles the favorite state of the recipe
    @objc
    private func toggleFavorite() {
        let action = isFavorite ? deleteFromFavorites : addToFavorites
        do { try action() }
        catch let error {
            let alert = UIAlertController.plainAlert(title: "Error", message: error.localizedDescription)
            present(alert, animated: true)
        }
        isFavorite.toggle()
        setupFavoriteButton()
        Recipe.favoritesListEdited = true
    }
    
    /// Adds the recipe to the favorites
    private func addToFavorites() throws {
        guard let recipe = recipe else { return }
        do { try StorageManager.shared.save(recipe: recipe) }
        catch let error { throw error }
        Recipe.favorites.append(recipe)
    }
    
    /// Removes the recipe from the favorites
    private func deleteFromFavorites() throws {
        guard let recipe = recipe else { return }
        do { try StorageManager.shared.delete(recipe: recipe) }
        catch let error { throw error }
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
    
    /// Display the recipes directions in a SafariViewController
    @objc
    private func goToRecipeDirections() {
        guard let recipe = recipe, let recipeURL = URL(string: recipe.url) else { return }
        let safariVC = SFSafariViewController(url: recipeURL)
        safariVC.preferredControlTintColor = Config.globalTintColor
        present(safariVC, animated: true, completion: nil)
    }
}
