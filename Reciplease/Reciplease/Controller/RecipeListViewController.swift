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
    /// Label to display a message
    var callbackLabel = UILabel()
    /// Image view to accompagn the callbackLabel
    var callbackImage = UIImageView()
    /// Stack view to embed the callback elements
    var callbackStackView = UIStackView()
    /// Background query indicator
    var activityindicator = UIActivityIndicatorView()
    /// Infinite scroll loading indicator
    var loadingLabel = UILabel()
    /// View controller state
    var state: State? { didSet {configure()} }
    /// Mode to indicates the context
    var mode: Mode
    /// List of recipes
    var recipes = [Recipe]()
    /// Number of recipes already received from API
    var offset = 0
    /// Allows infinite scrolling as long as the value is true
    var noMoreResults = false
    /// Ingredients to search in recipes
    var ingredients: String?
    
    /// Initializes  from code with mode
    init(mode: Mode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    /// Initializes from xib or storyboard with coder
    required init?(coder: NSCoder) {
        self.mode = .search
        super.init(coder: coder)
    }
}

// MARK: - Lifecycle
extension RecipeListViewController {
    
    /// Called after the controller's view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        state = .loading
    }
    
    /// Notifies the view controller that its view is about to be added to a view hierarchy
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard Recipe.favoritesListEdited,
            mode == .favorites
            else { return }
        loadFavorites()
    }
}

// MARK: - State
extension RecipeListViewController {
    
    /// Configures the display according to the view controller state
    private func configure() {
        guard let state = state else { return }
        switch state {
        case .loading:
            toggleViews(show: activityindicator)
            getRecipes()
        case .ready:
            toggleViews(show: tableView)
        case .infiniteScroll:
            loadingLabel.isHidden = false
        case .empty:
            toggleViews(show: callbackStackView)
            setUpCallbackStackViewData(systemName: "nosign")
        case .error:
            toggleViews(show: callbackStackView)
            setUpCallbackStackViewData(systemName: "xmark.octagon.fill")
        }
    }
    
    /// Shows the view which must bee displayed depending the view controller state
    private func toggleViews(show view: UIView) {
        [activityindicator, callbackStackView, tableView, loadingLabel]
        .forEach { $0.isHidden = view == $0 ? false : true }
    }
    
    /// Sets up data to display in the callback stack view
    private func setUpCallbackStackViewData(systemName: String) {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 150)
        callbackImage.image = UIImage(systemName: systemName, withConfiguration: imageConfig)
        guard let state = state else { return }
        let text = "\(state.title) \n\n \(state.message)"
        callbackLabel.text = text
    }
}

// MARK: - Setup
extension RecipeListViewController {
    
    /// Sets up the views
    private func setUpViews() {
        navigationItem.title = mode.title
        view.backgroundColor = .systemBackground
        tabBarController?.delegate = mode == .favorites ? self : nil
        setUpTableView()
        setupCallbackImage()
        setUpCallbackLabel()
        setUpCallbackStackView()
        setUpActivityIndicator()
        setUpLoadingLabel()
    }
    
    /// Sets up the table view
    private func setUpTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: Config.reuseIdentifier)
        tableView.separatorColor = .clear
        setUpTableViewConstraints()
    }
    
    /// Sets up the callback image
    private func setupCallbackImage() {
        callbackStackView.addArrangedSubview(callbackImage)
        callbackImage.contentMode = .scaleAspectFit
        callbackImage.tintColor = .secondaryLabel
    }
    
    /// Sets up the no recipe label
    private func setUpCallbackLabel() {
        callbackStackView.addArrangedSubview(callbackLabel)
        callbackLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        callbackLabel.textColor = .secondaryLabel
        callbackLabel.numberOfLines = 0
        callbackLabel.textAlignment = .center
    }
    
    /// Sets up the callbak stack view
    private func setUpCallbackStackView() {
        view.addSubview(callbackStackView)
        callbackStackView.axis = .vertical
        callbackStackView.alignment = .center
        setUpCallbackStackViewConstraints()
    }
    
    /// Sets up the activityIndicator
    private func setUpActivityIndicator() {
        view.addSubview(activityindicator)
        activityindicator.startAnimating()
        setUpActivityIndicatorConstraints()
    }
    
    /// Sets up the loading label
    private func setUpLoadingLabel() {
        view.addSubview(loadingLabel)
        loadingLabel.text = "... loading ..."
        loadingLabel.textColor = .secondaryLabel
        loadingLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        loadingLabel.isHidden = true
        setUpLoadingLabelConstraints()
    }
}

// MARK: - Constraints
extension RecipeListViewController {
    
    /// Sets up constraints for the table view
    private func setUpTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    /// Sets up constraints for the callback stack view
    private func setUpCallbackStackViewConstraints() {
        callbackStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            callbackStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            callbackStackView.widthAnchor.constraint(
                equalTo: view.readableContentGuide.widthAnchor,
                multiplier: 0.8),
            callbackStackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: view.frame.height/5)
        ])
    }
    
    /// Sets up constraints for the activity indicator
    private func setUpActivityIndicatorConstraints() {
        activityindicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityindicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityindicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setUpLoadingLabelConstraints() {
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.bottomAnchor.constraint(
                equalToSystemSpacingBelow: loadingLabel.bottomAnchor,
                multiplier: 0.5)
        ])
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
        recipeCell.recipe = recipes[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension RecipeListViewController: UITableViewDelegate {
    
    /// Tells the delegate that the specified row has been selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        goToRecipeDetail(of: recipe)
    }
    
    /// Checks if the user reach the last cells to request next recipes
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard mode == .search,
            noMoreResults == false,
            indexPath.row + 1 == tableView.numberOfRows(inSection: 0)
            else { return }
        state = .infiniteScroll
        getRecipesFromAPI()
    }
}

// MARK: - UITabBarControllerDelegate
extension RecipeListViewController: UITabBarControllerDelegate {
    
    /// Tells the delegate that the user selected an item in the tab bar
    func tabBarController(_ tabBarController: UITabBarController,didSelect viewController: UIViewController) {
        guard Recipe.favoritesListEdited,
            let favoritesNav = viewController as? FavoritesNavigationController,
            favoritesNav.visibleViewController is RecipeListViewController
            else { return }
        state = .loading
    }
}

// MARK: - Data
extension RecipeListViewController {
    
    /// Fetchs recipes from API or from storage depending the view controller mode
    private func getRecipes() {
        switch mode {
        case .search:
            getRecipesFromAPI()
        case .favorites:
            loadFavorites()
        }
    }
    
    /// Asks to receive recipes from API
    private func getRecipesFromAPI() {
        guard let ingredients = ingredients else { return }
        RecipeService.shared.getRecipes(ingredients: ingredients, offset: offset) { [weak self] (result) in
            switch(result) {
            case .success(let searchResult):
                self?.handleSuccess(result: searchResult)
            case .failure(let error):
                self?.handleFailure(result: error.errorDescription)
            }
        }
    }
    
    /// Handles a success result after a request
    private func handleSuccess(result searchResult: SearchResult) {
        recipes += searchResult.recipes
        let indexPaths = (offset..<recipes.count).map { IndexPath(row: $0, section: 0)}
        tableView.insertRows(at: indexPaths, with: .bottom)
        offset = recipes.count
        if recipes.isEmpty {
            noMoreResults = true
            state = .empty(mode: mode)
        } else {
            state = .ready
        }
    }
    
    /// Handles a failure result after a request
    private func handleFailure(result message: String?) {
        if recipes.isEmpty {
            state = .error(message: message)
        } else {
            let alert = UIAlertController.getPlainAlert(title: Strings.errorTitle, message: message)
            present(alert, animated: true)
            state = .ready
        }
    }
    
    /// Loads the favorite recipes from storage
    private func loadFavorites() {
        recipes = Recipe.favorites
        let lastVisibleIndexPath = tableView.indexPathsForVisibleRows
        tableView.reloadData()
        adjustCellsPosition(lastVisibleIndexPath: lastVisibleIndexPath)
        Recipe.favoritesListEdited = false
        state = recipes.isEmpty ? .empty(mode: mode) : .ready
    }
    
    /// Adjusts cells position to prevent an automatic ugly scroll
    private func adjustCellsPosition(lastVisibleIndexPath: [IndexPath]?) {
        guard Recipe.favoritesListEdited,
            tableView.numberOfRows(inSection: 0) > 0,
            let lastVisibleIndexPath = lastVisibleIndexPath,
            let indexPath = lastVisibleIndexPath.last
            else { return }
        let row = indexPath.row == 0 ? indexPath.row : indexPath.row - 1
        tableView.scrollToRow(at: IndexPath(row: row, section: 0), at: .none, animated: false)
    }
}


// MARK: - Navigation
extension RecipeListViewController {
    
    /// Calls the recipe detail screen
    func goToRecipeDetail(of recipe: Recipe) {
        let recipeDetailVC = RecipeDetailViewController()
        recipeDetailVC.recipe = recipe
        recipeDetailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(recipeDetailVC, animated: true)
    }
}


