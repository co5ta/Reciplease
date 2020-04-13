//
//  SearchFormViewController.swift
//  Reciplease
//
//  Created by co5ta on 13/03/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import UIKit

/// Controller of the search form screen
class SearchFormViewController: UIViewController {
    
    /// Scroll view
    var scrollView = UIScrollView()
    /// Search form view
    var searchFormView = SearchFormView()
    /// Array of ingredients
    var ingredients = [String]()
}


// MARK: - Lifecycle
extension SearchFormViewController {
    
    /// Called after the controller's view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
}

// MARK: - Setup
extension SearchFormViewController {
    
    /// Sets up the views
    private func setUpViews() {
        setUpDefaultProperties()
        setUpScrollView()
        setUpSearchFormView()
    }
    
    /// Sets up default properties of the controller
    private func setUpDefaultProperties() {
        navigationItem.title = "Reciplease"
        let button = UIBarButtonItem(title: "", style: .plain,target: nil, action: nil)
        navigationItem.backBarButtonItem = button
        view.backgroundColor = .systemBackground
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    /// Sets up the scroll view
    private func setUpScrollView() {
        view.addSubview(scrollView)
        setUpScrollViewConstraints()
    }

    /// Sets up the search form view
    private func setUpSearchFormView() {
        scrollView.addSubview(searchFormView)
        searchFormView.addButton.addTarget(self, action: #selector(addIngredient), for: .touchUpInside)
        searchFormView.clearButton.addTarget(self, action: #selector(removeIngredients), for: .touchUpInside)
        searchFormView.submitButton.addTarget(self, action: #selector(goToSearchResultScreen), for: .touchUpInside)
        setUpSearchFormViewConstraints()
    }
    
}

// MARK: - Constraints
extension SearchFormViewController {
 
    /// Sets up the constraints of the scroll view
    private func setUpScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    /// Sets up the constraints of the search view form
    private func setUpSearchFormViewConstraints() {
        searchFormView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchFormView.heightAnchor.constraint(
                greaterThanOrEqualTo: view.safeAreaLayoutGuide.heightAnchor),
            searchFormView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            searchFormView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            searchFormView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}


// MARK: - Actions
extension SearchFormViewController {
    
    /// Adds an ingredient to the list
    @objc
    func addIngredient() {
        guard let newIngredient = searchFormView.textField.text, newIngredient != "" else { return }
        ingredients.append(newIngredient)
        let joinedIngredients = ingredients.joined(separator: "\n- ")
        searchFormView.ingredientsList.text = "- \(joinedIngredients)"
        searchFormView.textField.text = ""
    }
    
    /// Removes ingredients added
    @objc
    func removeIngredients() {
        ingredients.removeAll()
        searchFormView.ingredientsList.text = ""
    }
    
    /// Hides the keyboard when needed
    @objc
    func dismissKeyboard() {
        searchFormView.textField.resignFirstResponder()
    }
}


// MARK: - Navigation
extension SearchFormViewController {

    /// Calls the search result screen
    @objc
    func goToSearchResultScreen() {
        guard ingredients.isEmpty == false else { return }
        let searchResultScreen = RecipeListViewController(mode: .search)
        searchResultScreen.ingredients = ingredients.joined(separator: " ")
        navigationController?.pushViewController(searchResultScreen, animated: true)
    }
}
