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
    /// List of recipes
    var recipes = [Recipe]()
    /// Tableview to display the recipes
    var tableView = UITableView()
    /// Label to inform that no recipe was found
    var noRecipeLabel = UILabel()
    /// Background query indicator
    var activityindicator = UIActivityIndicatorView()
}

// MARK: - Lifecycle
extension SearchResultViewController {
    
    /// Called after the controller's view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        getRecipes()
    }
}

// MARK: - Setup
extension SearchResultViewController {
    
    /// Sets up the views
    func setUpViews() {
        navigationItem.title = "Search"
        view.backgroundColor = UIColor.white
        setUpTableView()
        setUpNoRecipeLabel()
        setUpActivityIndicator()
    }
    
    /// Sets up the table view
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: Config.reuseIdentifier)
        tableView.separatorColor = .white
        tableView.isHidden = true
        view.addSubview(tableView)
        setUpTableViewConstraints()
    }
    
    /// Sets up the no recipe label
    private func setUpNoRecipeLabel() {
        noRecipeLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        noRecipeLabel.text = "No recipe found"
        noRecipeLabel.isHidden = true
        view.addSubview(noRecipeLabel)
        setUpNoRecipeLabelConstraints()
    }
    
    /// Sets up the activityIndicator
    private func setUpActivityIndicator() {
        activityindicator.startAnimating()
        view.addSubview(activityindicator)
        setUpActivityIndicatorConstraints()
    }
}

// MARK: - Constraints
extension SearchResultViewController {
    
    /// Sets up constraints for the table view
    private func setUpTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor).isActive = true
    }
    
    /// Sets up constraints for the no recipe label
    private func setUpNoRecipeLabelConstraints() {
        noRecipeLabel.translatesAutoresizingMaskIntoConstraints = false
        noRecipeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noRecipeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    /// Sets up constraints for the activity indicator
    private func setUpActivityIndicatorConstraints() {
        activityindicator.translatesAutoresizingMaskIntoConstraints = false
        activityindicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityindicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

// MARK: - DataSource
extension SearchResultViewController: UITableViewDataSource {
    
    /// Tells the data source to return the number of rows in a given section of a table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    /// Asks the data source for a cell to insert in a particular location of the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Config.reuseIdentifier, for: indexPath)
        guard let recipeCell = cell as? RecipeTableViewCell else { return cell }
        let recipe = recipes[indexPath.row]
        recipeCell.recipePreview.fetchData(with: recipe)
        return cell
    }
}

// MARK: - Delegate
extension SearchResultViewController: UITableViewDelegate {
    
    /// Tells the delegate that the specified row is now selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        goToRecipeDetail(of: recipe)
    }
}

// MARK: - Data
extension SearchResultViewController {
    
    /// Launchs the recipes search
    func getRecipes() {
        guard let ingredients = ingredients else { return }
        toggleActivityindicator(loading: true)
        RecipeService.shared.getRecipes(ingredients: ingredients) { [weak self] (response) in
            switch(response) {
            case .success(let searchResult):
                self?.recipes = searchResult.recipes
                self?.tableView.reloadData()
            case .failure:
                print("no result")
            }
            self?.toggleActivityindicator(loading: false)
        }
    }
    
    /// Toggles the activity controller to show request in progress
    func toggleActivityindicator(loading: Bool) {
        activityindicator.isHidden = !loading
        if loading == false {
            tableView.isHidden = recipes.isEmpty
            noRecipeLabel.isHidden = !recipes.isEmpty
        }
    }
}


// MARK: - Navigation
extension SearchResultViewController {
    
    /// Calls the recipe detail screen
    func goToRecipeDetail(of recipe: Recipe) {
        let recipeDetailVC = RecipeDetailViewController()
        recipeDetailVC.recipe = recipe
        navigationController?.pushViewController(recipeDetailVC, animated: true)
    }
}
