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
    
    /// Section of the ingredient textField
    var textFieldView = UIView()
    /// Label of the textField
    var textFieldLabel = UILabel()
    /// TextField to add ingredients
    var textField = UITextField()
    /// Bottom border of the textField
    var textFieldBorder = UIView()
    /// Button to validate the addition of an ingredient
    var addButton = UIButton(type: .system)
    /// Section of the ingredients list
    var ingredientsView = UIView()
    /// Title of the ingredient section
    var ingredientsTitleLabel = UILabel()
    /// TextView which display the ingredients added
    var ingredientsList = UITextView()
    /// Button to clear the ingredients list
    var clearButton = UIButton(type: .system)
    /// Button to submit the form
    var submitButton = UIButton(type: .system)
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
        setUpNavigationItem()
        setUpRootView()
        setUpTextFieldSection()
        setUpTextFieldLabel()
        setUpTextField()
        setUpTextFieldBorder()
        setUpAddButton()
        setUpIngredientsSection()
        setUpIngredientsTitle()
        setUpIngredientsList()
        setUpClearButton()
        setUpSubmitButton()
    }
    
    /// Sets up the navigation item
    private func setUpNavigationItem() {
        navigationItem.title = "Reciplease"
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil)
    }
    
    /// Sets up the root view
    private func setUpRootView() {
        view.backgroundColor = .systemBackground
        let tapView = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapView)
    }
    
    /// Sets up the text field section
    private func setUpTextFieldSection() {
        view.addSubview(textFieldView)
        textFieldView.backgroundColor = .tertiarySystemBackground
        textFieldView.layer.shadowColor = UIColor.separator.cgColor
        textFieldView.layer.shadowOffset = CGSize(width: 1, height: 1)
        textFieldView.layer.shadowOpacity = 1
        textFieldView.layer.shadowRadius = 5
        textFieldView.layer.cornerRadius = 10
        setUpTextFieldViewConstraints()
    }
    
    /// Sets up the text field label
    private func setUpTextFieldLabel() {
        view.addSubview(textFieldLabel)
        textFieldLabel.text = "What's on your fridge ?"
        textFieldLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        setUpTextFieldLabelConstraints()
    }
    
    /// Sets up the text field
    private func setUpTextField() {
        view.addSubview(textField)
        textField.placeholder = "Lemon, Cheese, Sausages..."
        setUpTextFieldConstraints()
    }
    
    /// Sets up the text field border
    private func setUpTextFieldBorder() {
        view.addSubview(textFieldBorder)
        textFieldBorder.backgroundColor = .opaqueSeparator
        setUpTextFieldBorderConstraints()
    }
    
    /// Sets up the add button
    private func setUpAddButton() {
        view.addSubview(addButton)
        addButton.setTitle("Add", for: .normal)
        addButton.tintColor = .white
        addButton.backgroundColor = Config.globalTintColor
        addButton.layer.cornerRadius = 5
        addButton.addTarget(self, action: #selector(addIngredient), for: .touchUpInside)
        setUpAddButtonConstraints()
    }
    
    /// Sets up the ingredients section
    private func setUpIngredientsSection() {
        view.addSubview(ingredientsView)
        ingredientsView.backgroundColor = .tertiarySystemBackground
        ingredientsView.layer.shadowColor = UIColor.separator.cgColor
        ingredientsView.layer.shadowOffset = CGSize(width: 1, height: 1)
        ingredientsView.layer.shadowOpacity = 1
        ingredientsView.layer.shadowRadius = 5
        ingredientsView.layer.cornerRadius = 10
        setUpIngredientsViewConstraints()
    }
    
    /// Sets up the ingredients title
    private func setUpIngredientsTitle() {
        view.addSubview(ingredientsTitleLabel)
        ingredientsTitleLabel.text = "Your ingredients :"
        ingredientsTitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        setUpIngredientsTitleConstraints()
    }
    
    /// Sets up the ingredients list
    private func setUpIngredientsList() {
        view.addSubview(ingredientsList)
        ingredientsList.font = UIFont.preferredFont(forTextStyle: .body)
        ingredientsList.backgroundColor = .tertiarySystemBackground
        ingredientsList.isSelectable = false
        setUpIngredientsListConstraints()
    }
    
    /// Sets up the clear button
    private func setUpClearButton() {
        view.addSubview(clearButton)
        clearButton.tintColor = .white
        clearButton.backgroundColor = Config.cancelButtonColor
        clearButton.setTitle("Clear", for: .normal)
        clearButton.layer.cornerRadius = 5
        clearButton.addTarget(self, action: #selector(removeIngredients), for: .touchUpInside)
        setUpClearButtonConstraints()
    }
    
    /// Sets up the submit button
    private func setUpSubmitButton() {
        view.addSubview(submitButton)
        submitButton.tintColor = .white
        submitButton.backgroundColor = Config.globalTintColor
        submitButton.setTitle("Search for recipes", for: .normal)
        submitButton.layer.cornerRadius = 5
        submitButton.addTarget(
            self,
            action: #selector(goToSearchResultScreen),
            for: .touchUpInside)
        setUpSubmitButtonConstraints()
    }
}

// MARK: - Constraints
extension SearchFormViewController {
 
    /// Sets up constraints for the text field section
    private func setUpTextFieldViewConstraints() {
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        textFieldView.heightAnchor.constraint(
            equalTo: textFieldView.widthAnchor,
            multiplier: 2/5).isActive = true
        textFieldView.topAnchor.constraint(
            equalToSystemSpacingBelow: view.readableContentGuide.topAnchor,
            multiplier: 3).isActive = true
        textFieldView.leadingAnchor.constraint(
            equalToSystemSpacingAfter: view.leadingAnchor,
            multiplier: 2).isActive = true
        view.trailingAnchor.constraint(
            equalToSystemSpacingAfter: textFieldView.trailingAnchor,
            multiplier: 2).isActive = true
    }
    
    /// Sets up constraints for the text field label
    private func setUpTextFieldLabelConstraints() {
        textFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        textFieldLabel.topAnchor.constraint(
            equalToSystemSpacingBelow: textFieldView.topAnchor,
            multiplier: 2).isActive = true
        textFieldLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: textFieldView.leadingAnchor, multiplier: 2).isActive = true
    }
    
    /// Sets up constraints for the text field
    private func setUpTextFieldConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(
            equalToSystemSpacingAfter: textFieldView.leadingAnchor,
            multiplier: 2).isActive = true
    }
    
    /// Sets up constraints for the text field border
    private func setUpTextFieldBorderConstraints() {
        textFieldBorder.translatesAutoresizingMaskIntoConstraints = false
        textFieldBorder.heightAnchor.constraint(
            equalToConstant: 1).isActive = true
        textFieldBorder.widthAnchor.constraint(
            equalTo: textField.widthAnchor).isActive = true
        textFieldBorder.centerXAnchor.constraint(
            equalTo: textField.centerXAnchor).isActive = true
        textFieldBorder.topAnchor.constraint(
            equalTo: textField.bottomAnchor).isActive = true
    }
    
    /// Sets up constraints for add button
    private func setUpAddButtonConstraints() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.heightAnchor.constraint(
            equalToConstant: 40).isActive = true
        addButton.widthAnchor.constraint(
            equalToConstant: 60).isActive = true
        textFieldView.trailingAnchor.constraint(
            equalToSystemSpacingAfter: addButton.trailingAnchor,
            multiplier: 2).isActive = true
        addButton.leadingAnchor.constraint(
            equalToSystemSpacingAfter: textField.trailingAnchor,
            multiplier: 2).isActive = true
        addButton.bottomAnchor.constraint(
            equalToSystemSpacingBelow: textFieldBorder.bottomAnchor,
            multiplier: 0.1).isActive = true
        textFieldView.bottomAnchor.constraint(
            equalToSystemSpacingBelow: addButton.bottomAnchor,
            multiplier: 2).isActive = true
        
    }
    
    /// Sets up constraints for the ingredients section
    private func setUpIngredientsViewConstraints() {
        ingredientsView.translatesAutoresizingMaskIntoConstraints = false
        ingredientsView.topAnchor.constraint(
            equalToSystemSpacingBelow: textFieldView.bottomAnchor,
            multiplier: 3).isActive = true
        ingredientsView.leadingAnchor.constraint(
            equalTo: textFieldView.leadingAnchor).isActive = true
        ingredientsView.trailingAnchor.constraint(
            equalTo: textFieldView.trailingAnchor).isActive = true
        view.readableContentGuide.bottomAnchor.constraint(
            equalToSystemSpacingBelow: ingredientsView.bottomAnchor,
            multiplier: 3).isActive = true
    }
    
    /// Sets up constraints for the ingredients title
    private func setUpIngredientsTitleConstraints() {
        ingredientsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientsTitleLabel.topAnchor.constraint(
            equalToSystemSpacingBelow: ingredientsView.topAnchor,
            multiplier: 2).isActive = true
        ingredientsTitleLabel.leadingAnchor.constraint(
            equalToSystemSpacingAfter: ingredientsView.leadingAnchor,
            multiplier: 2).isActive = true
    }
    
    /// Sets up constraints for the ingredients list
    private func setUpIngredientsListConstraints() {
        ingredientsList.translatesAutoresizingMaskIntoConstraints = false
        ingredientsList.topAnchor.constraint(
            equalToSystemSpacingBelow: ingredientsTitleLabel.bottomAnchor,
            multiplier: 2).isActive = true
        ingredientsList.leadingAnchor.constraint(
            equalTo: ingredientsTitleLabel.leadingAnchor).isActive = true
        ingredientsView.trailingAnchor.constraint(
            equalToSystemSpacingAfter: ingredientsList.trailingAnchor,
            multiplier: 2).isActive = true
    }
    
    /// Sets up constraints for the clear button
    private func setUpClearButtonConstraints() {
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.heightAnchor.constraint(
            equalToConstant: 50).isActive = true
        clearButton.topAnchor.constraint(
            equalToSystemSpacingBelow: ingredientsList.bottomAnchor,
            multiplier: 2).isActive = true
        clearButton.leadingAnchor.constraint(
            equalToSystemSpacingAfter: ingredientsView.leadingAnchor,
            multiplier: 2).isActive = true
        ingredientsView.bottomAnchor.constraint(
            equalToSystemSpacingBelow: clearButton.bottomAnchor,
            multiplier: 2).isActive = true
    }
    
    /// Sets up constraints for the submit button
    private func setUpSubmitButtonConstraints() {
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.heightAnchor.constraint(
            equalTo: clearButton.heightAnchor).isActive = true
        submitButton.widthAnchor.constraint(
            equalTo: clearButton.widthAnchor).isActive = true
        submitButton.leadingAnchor.constraint(
            equalToSystemSpacingAfter: clearButton.trailingAnchor,
            multiplier: 2).isActive = true
        ingredientsView.trailingAnchor.constraint(
            equalToSystemSpacingAfter: submitButton.trailingAnchor,
            multiplier: 2).isActive = true
        submitButton.bottomAnchor.constraint(
            equalTo: clearButton.bottomAnchor).isActive = true
        
        
    }
}


// MARK: - Actions
extension SearchFormViewController {
    
    /// Adds an ingredient to the list
    @objc
    func addIngredient() {
        guard let newIngredient = textField.text, newIngredient != "" else { return }
        ingredients.append(newIngredient)
        let joinedIngredients = ingredients.joined(separator: "\n- ")
        ingredientsList.text = "- \(joinedIngredients)"
        textField.text = ""
    }
    
    /// Removes ingredients added
    @objc
    func removeIngredients() {
        ingredients.removeAll()
        ingredientsList.text = ""
    }
    
    /// Hides the keyboard when needed
    @objc
    func dismissKeyboard() {
        textField.resignFirstResponder()
    }
}


// MARK: - Navigation
extension SearchFormViewController {

    /// Calls the search result screen
    @objc
    func goToSearchResultScreen() {
        guard ingredients.isEmpty == false else { return }
        let searchResultScreen = RecipeListViewController(mode: .searchResult)
        searchResultScreen.ingredients = ingredients.joined(separator: " ")
        navigationController?.pushViewController(searchResultScreen, animated: true)
    }
}
