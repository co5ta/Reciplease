//
//  RecipeListViewController.swift
//  Reciplease
//
//  Created by co5ta on 17/03/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import UIKit

/// Controller of the search result screen
class RecipeListViewController: UIViewController {
    
    /// Tableview to display the recipes
    var tableView = UITableView()
    /// Label to inform that no recipe was found
    var noRecipeLabel = UILabel()
    /// Background query indicator
    var activityindicator = UIActivityIndicatorView()
    /// Button to load more recipes
    var loadMoreButton = UIButton()
    /// View controller mode that indicates the context is search result by default
    var mode: Mode = .searchResult
    /// List of recipes
    var recipes = [Recipe]()
    /// Ingredients to search in recipes
    var ingredients: String?
    
    /// Initializes  from code with mode
    init(mode: Mode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    /// Initializes from xib or storyboard with coder
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Lifecycle
extension RecipeListViewController {
    
    /// Called after the controller's view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        if ingredients == nil { tabBarController?.delegate = self }
        setUpViews()
        getRecipes()
    }
    
    /// Notifies the view controller that its view is about to be added to a view hierarchy
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard Recipe.favoritesListEdited else { return }
        loadFavorites()
    }
}

// MARK: - Setup
extension RecipeListViewController {
    
    /// Sets up the views
    func setUpViews() {
        navigationItem.title = "Search"
        view.backgroundColor = UIColor.white
        setUpTableView()
        setUpNoRecipeLabel()
        setUpActivityIndicator()
        setUpLoadMoreButton()
    }
    
    /// Sets up the table view
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: Config.reuseIdentifier)
        tableView.separatorColor = .clear
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
    
    /// Sets up the load more button
    private func setUpLoadMoreButton() {
        loadMoreButton.setTitle("Load more", for: .normal)
    }
}

// MARK: - Constraints
extension RecipeListViewController {
    
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

// MARK: - UITableViewDataSource
extension RecipeListViewController: UITableViewDataSource {
    
    /// Tells the data source to return the number of rows in a given section of a table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    /// Asks the data source for a cell to insert in a particular location of the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Config.reuseIdentifier, for: indexPath)
        guard let recipeCell = cell as? RecipeTableViewCell else { return cell }
        recipeCell.recipePreview.recipe = recipes[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension RecipeListViewController: UITableViewDelegate {
    
    /// Tells the delegate that the specified row is now selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        goToRecipeDetail(of: recipe)
    }
    
    /// Checks if the user reach the last cells to request next recipes
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard ingredients != nil else { return }
        guard indexPath.row + 1 == tableView.numberOfRows(inSection: 0) else { return }
        getRecipesFromAPI()
    }
}

// MARK: - UITabBarControllerDelegate
extension RecipeListViewController: UITabBarControllerDelegate {
    
    /// Tells the delegate that the user selected an item in the tab bar
    func tabBarController(_ tabBarController: UITabBarController,didSelect viewController: UIViewController) {
        guard let favoritesNav = viewController as? FavoritesNavigationController else { return }
        guard favoritesNav.visibleViewController is RecipeListViewController else { return }
        loadFavorites()
    }
}

// MARK: - Data
extension RecipeListViewController {
    
    /// Fetchs recipes from API or from storage depending the view controller mode
    private func getRecipes() {
        switch mode {
        case .searchResult:
            getRecipesFromAPI()
        case .favorites:
            loadFavorites()
        }
    }
    
    /// Asks to receive recipes from API
    private func getRecipesFromAPI() {
        guard let ingredients = ingredients else { return }
        toggleActivityindicator(loading: true)
        let offset = tableView.numberOfRows(inSection: 0)
        RecipeService.shared.getRecipes(ingredients: ingredients, offset: offset) { [weak self] (response) in
            guard let self = self else { return }
            switch(response) {
            case .success(let searchResult):
                self.recipes += searchResult.recipes
                let indexPaths = (offset..<self.recipes.count).map { IndexPath(row: $0, section: 0)}
                self.tableView.insertRows(at: indexPaths, with: Config.tableViewRowAnimation)
                self.toggleActivityindicator(loading: false)
            case .failure:
                print("no result")
                self.toggleActivityindicator(loading: false)
            }
        }
    }
    
    /// Asks to receive favorite recipes from storage
    private func loadFavorites() {
        guard mode == .favorites else { return }
        toggleActivityindicator(loading: true)
        recipes = Recipe.favorites
        let lastVisibleIndexPath = tableView.indexPathsForVisibleRows
        tableView.reloadData()
        toggleActivityindicator(loading: false)
        adjustCellsPosition(lastVisibleIndexPath: lastVisibleIndexPath)
    }
    
    /// Adjusts cells position to prevent an automatic ugly scroll
    private func adjustCellsPosition(lastVisibleIndexPath: [IndexPath]?) {
        guard Recipe.favoritesListEdited else { return }
        guard tableView.numberOfRows(inSection: 0) > 0 else { return }
        guard let lastVisibleIndexPath = lastVisibleIndexPath, let indexPath = lastVisibleIndexPath.last else { return }
        let row = indexPath.row == 0 ? indexPath.row : indexPath.row - 1
        tableView.scrollToRow(at: IndexPath(row: row, section: 0), at: .none, animated: false)
        Recipe.favoritesListEdited = false
    }
    
    /// Toggles the activity controller to show request in progress
    private func toggleActivityindicator(loading: Bool) {
        activityindicator.isHidden = !loading
        guard loading == false else { return }
        tableView.isHidden = recipes.isEmpty
        noRecipeLabel.isHidden = !recipes.isEmpty
    }
}


// MARK: - Navigation
extension RecipeListViewController {
    
    /// Calls the recipe detail screen
    func goToRecipeDetail(of recipe: Recipe) {
        let recipeDetailVC = RecipeDetailViewController()
        recipeDetailVC.recipe = recipe
        navigationController?.pushViewController(recipeDetailVC, animated: true)
    }
}

// MARK: - Enum
extension RecipeListViewController {
    
    /// Indicates the context of the view controller
    enum Mode {
        /// The mode that displays the recipes from the search result
        case searchResult
        /// The mode that displays the recipes saved as favorites
        case favorites
    }
}
