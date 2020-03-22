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
    /// Identifer of the tableview cell
    let reuseIdentifier = "RecipeCell"
    /// Tableview to display the recipes
    var tableView: UITableView!
    /// Label to inform that no recipe was found
    var noRecipeLabel: UILabel!
    /// Background query indicator
    var activityindicator: UIActivityIndicatorView!
}

// MARK: - Life cycle
extension SearchResultViewController {
    
    /// Setup the views
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        getRecipes()
    }
}

// MARK: - UI Components
extension SearchResultViewController {
    
    /// Setup the components to display
    func initUI() {
        addSubViews()
        addConstraints()
    }
    
    /// Add the components to display
    func addSubViews() {
        view.backgroundColor = UIColor.white
        
        tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RecipeCell")
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        view.addSubview(tableView)
        
        noRecipeLabel = UILabel()
        noRecipeLabel.text = "No recipe found"
        noRecipeLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        noRecipeLabel.translatesAutoresizingMaskIntoConstraints = false
        noRecipeLabel.isHidden = true
        view.addSubview(noRecipeLabel)
        
        activityindicator = UIActivityIndicatorView()
        activityindicator.startAnimating()
        activityindicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityindicator)
    }
    
    /// Add constraints to the components to display
    func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.heightAnchor.constraint(equalTo: view.readableContentGuide.heightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            noRecipeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noRecipeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            activityindicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityindicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

// MARK: - Data Source
extension SearchResultViewController: UITableViewDataSource {
    
    /// Tells the data source to return the number of rows in a given section of a table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.isEmpty ? 0 : recipes.count
    }
    
    /// Asks the data source for a cell to insert in a particular location of the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        guard recipes.isEmpty == false else { return cell }
        let recipe = recipes[indexPath.row]
        cell.textLabel?.text = recipe.label
        cell.detailTextLabel?.text = recipe.url
        return cell
    }
    
    /// Launch the recipes search
    func getRecipes() {
        guard let ingredients = ingredients else { return }
        toggleLoading(show: true)
        RecipeService.shared.getRecipes(ingredients: ingredients) { [weak self] (response) in
            switch(response) {
            case .success(let searchResult):
                self?.recipes = searchResult.recipes
                self?.tableView.reloadData()
            case .failure:
                print("no result")
            }
            self?.toggleLoading(show: false)
        }
    }
    
    /// Toggle the activity controller to show request in progress
    func toggleLoading(show: Bool) {
        activityindicator.isHidden = !show
        if show == false {
            tableView.isHidden = recipes.isEmpty
            noRecipeLabel.isHidden = !recipes.isEmpty
        }
    }
}
