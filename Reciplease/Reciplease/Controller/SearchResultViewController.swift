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
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        return tableView
    }()
    
    /// Label to inform that no recipe was found
    var noRecipeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    /// Background query indicator
    var activityindicator: UIActivityIndicatorView = {
        let activityindicator = UIActivityIndicatorView()
        activityindicator.startAnimating()
        activityindicator.translatesAutoresizingMaskIntoConstraints = false
        return activityindicator
    }()
}

// MARK: - Life cycle
extension SearchResultViewController {
    
    /// Setup the views
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search"
        navigationItem.backBarButtonItem?.tintColor = .red
        addViews()
        activateConstraints()
        configure()
        getRecipes()
    }
}

// MARK: - UI Components
extension SearchResultViewController {
    
    /// Add the components to display
    func addViews() {
        view.addSubview(tableView)
        view.addSubview(noRecipeLabel)
        view.addSubview(activityindicator)
    }
    
    /// Add constraints to the components to display
    func activateConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor),
            
            noRecipeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noRecipeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            activityindicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityindicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    /// Cnnfigure the views
    func configure() {
        view.backgroundColor = UIColor.white
        noRecipeLabel.text = "No recipe found"
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: Config.RecipeCellReuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - Data Source
extension SearchResultViewController: UITableViewDataSource {
    
    /// Tells the data source to return the number of rows in a given section of a table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    /// Asks the data source for a cell to insert in a particular location of the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Config.RecipeCellReuseIdentifier, for: indexPath) as? RecipeTableViewCell else {
            return tableView.dequeueReusableCell(withIdentifier: Config.RecipeCellReuseIdentifier, for: indexPath)
        }
        let recipe = recipes[indexPath.row]
        cell.configure(with: recipe)
        return cell
    }
}

// MARK: - Delegate
extension SearchResultViewController: UITableViewDelegate {
    
    /// Asks the delegate for the height to use for a row in a specified location.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}

// MARK: - Request
extension SearchResultViewController {
    
    /// Launch the recipes search
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
    
    /// Toggle the activity controller to show request in progress
    func toggleActivityindicator(loading: Bool) {
        activityindicator.isHidden = !loading
        if loading == false {
            tableView.isHidden = recipes.isEmpty
            noRecipeLabel.isHidden = !recipes.isEmpty
        }
    }
}

