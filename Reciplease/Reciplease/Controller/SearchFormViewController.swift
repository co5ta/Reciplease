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
    var ingredientsTextView = UITextView()
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
        navigationItem.title = "Reciplease"
        setUpRootView()
        setUpTextFieldSection()
        setUpTextFieldLabel()
        setUpTextField()
        setUpTextFieldBorder()
        setUpAddButton()
        setUpIngredientsSection()
        setUpIngredientsTitle()
        setUpClearButton()
        setUpIngredientsList()
        setUpSubmitButton()
    }
    
    /// Sets up the root view
    private func setUpRootView() {
        view.backgroundColor = .white
        let tapView = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapView)
    }
    
    /// Sets up the text field section
    private func setUpTextFieldSection() {
        view.addSubview(textFieldView)
        textFieldView.backgroundColor = .white
        textFieldView.layer.cornerRadius = 10
        textFieldView.layer.shadowColor = UIColor.lightGray.cgColor
        textFieldView.layer.shadowOpacity = 0.5
        textFieldView.layer.shadowOffset = CGSize(width: 1, height: 1)
        textFieldView.layer.shadowRadius = 7
        setUpTextFieldSectionConstraints()
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
        textFieldBorder.backgroundColor = .lightGray
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
        ingredientsView.backgroundColor = .white
        ingredientsView.layer.borderColor = UIColor.lightGray.cgColor
        ingredientsView.layer.shadowColor = UIColor.lightGray.cgColor
        ingredientsView.layer.shadowOpacity = 0.5
        ingredientsView.layer.shadowOffset = CGSize(width: 1, height: 1)
        ingredientsView.layer.shadowRadius = 10
        ingredientsView.layer.cornerRadius = 10
        setUpIngredientsSectionConstraints()
    }
    
    /// Sets up the ingredients title
    private func setUpIngredientsTitle() {
        view.addSubview(ingredientsTitleLabel)
        ingredientsTitleLabel.text = "Your ingredients :"
        ingredientsTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        ingredientsTitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        setUpIngredientsTitleConstraints()
    }
    
    /// Sets up the clear button
    private func setUpClearButton() {
        view.addSubview(clearButton)
        clearButton.tintColor = .white
        clearButton.backgroundColor = Config.cancelButtonColor
        clearButton.setTitle("Clear", for: .normal)
        clearButton.layer.cornerRadius = 5
        setUpClearButtonConstraints()
    }
    
    /// Sets up the ingredients list
    private func setUpIngredientsList() {
        view.addSubview(ingredientsTextView)
        ingredientsTextView.font = UIFont.preferredFont(forTextStyle: .body)
        ingredientsTextView.isSelectable = false
        setUpIngredientsListConstraints()
    }
    
    /// Sets up the submit button
    private func setUpSubmitButton() {
        view.addSubview(submitButton)
        submitButton.tintColor = .white
        submitButton.backgroundColor = Config.globalTintColor
        submitButton.setTitle("Search for recipes", for: .normal)
        submitButton.layer.cornerRadius = 5
        submitButton.addTarget(self, action: #selector(goToSearchResultScreen), for: .touchUpInside)
        setUpSubmitButtonConstraints()
    }
}

// MARK: - Constraints
extension SearchFormViewController {
 
    /// Sets up constraints for the text field section
    private func setUpTextFieldSectionConstraints() {
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        textFieldView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor, constant: 30).isActive = true
        textFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        textFieldView.heightAnchor.constraint(equalTo: textFieldView.widthAnchor, multiplier: 2/5).isActive = true
    }
    
    /// Sets up constraints for the text field label
    private func setUpTextFieldLabelConstraints() {
        textFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        textFieldLabel.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 15).isActive = true
        textFieldLabel.centerXAnchor.constraint(equalTo: textFieldView.centerXAnchor).isActive = true
    }
    
    /// Sets up constraints for the text field
    private func setUpTextFieldConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 15).isActive = true
        textField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -20).isActive = true
    }
    
    /// Sets up constraints for the text field border
    private func setUpTextFieldBorderConstraints() {
        textFieldBorder.translatesAutoresizingMaskIntoConstraints = false
        textFieldBorder.widthAnchor.constraint(equalTo: textField.widthAnchor).isActive = true
        textFieldBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
        textFieldBorder.centerXAnchor.constraint(equalTo: textField.centerXAnchor).isActive = true
        textFieldBorder.topAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
    }
    
    /// Sets up constraints for add button
    private func setUpAddButtonConstraints() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        addButton.bottomAnchor.constraint(equalTo: textFieldBorder.bottomAnchor).isActive = true
        addButton.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -15).isActive = true
    }
    
    /// Sets up constraints for the ingredients section
    private func setUpIngredientsSectionConstraints() {
        ingredientsView.translatesAutoresizingMaskIntoConstraints = false
        ingredientsView.topAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: 30).isActive = true
        ingredientsView.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor).isActive = true
        ingredientsView.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor).isActive = true
        ingredientsView.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor, constant: -30).isActive = true
    }
    /// Sets up constraints for the ingredients title
    private func setUpIngredientsTitleConstraints() {
        ingredientsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientsTitleLabel.leadingAnchor.constraint(equalTo: ingredientsView.leadingAnchor, constant: 15).isActive = true
    }
    
    /// Sets up constraints for the clear button
    private func setUpClearButtonConstraints() {
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        clearButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        clearButton.centerYAnchor.constraint(equalTo: ingredientsTitleLabel.centerYAnchor).isActive = true
        clearButton.topAnchor.constraint(equalTo: ingredientsView.topAnchor, constant: 15).isActive = true
        clearButton.leadingAnchor.constraint(equalTo: ingredientsTitleLabel.trailingAnchor).isActive = true
        clearButton.trailingAnchor.constraint(equalTo: ingredientsView.trailingAnchor, constant: -15).isActive = true
        clearButton.addTarget(self, action: #selector(removeIngredients), for: .touchUpInside)
    }
    
    /// Sets up constraints for the ingredients list
    private func setUpIngredientsListConstraints() {
        ingredientsTextView.translatesAutoresizingMaskIntoConstraints = false
        ingredientsTextView.topAnchor.constraint(equalTo: ingredientsTitleLabel.topAnchor, constant: 30).isActive = true
        ingredientsTextView.leadingAnchor.constraint(equalTo: ingredientsTitleLabel.leadingAnchor).isActive = true
        ingredientsTextView.trailingAnchor.constraint(equalTo: ingredientsView.trailingAnchor).isActive = true
    }
    
    /// Sets up constraints for the submit button
    private func setUpSubmitButtonConstraints() {
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.heightAnchor.constraint(equalTo: submitButton.widthAnchor, multiplier: 1/6).isActive = true
        submitButton.centerXAnchor.constraint(equalTo: ingredientsView.centerXAnchor).isActive = true
        submitButton.topAnchor.constraint(equalTo: ingredientsTextView.bottomAnchor, constant: -30).isActive = true
        submitButton.leadingAnchor.constraint(equalTo: ingredientsView.leadingAnchor, constant: 30).isActive = true
        submitButton.trailingAnchor.constraint(equalTo: ingredientsView.trailingAnchor, constant: -30).isActive = true
        submitButton.bottomAnchor.constraint(equalTo: ingredientsView.bottomAnchor, constant: -30).isActive = true
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
        ingredientsTextView.text = "- \(joinedIngredients)"
        textField.text = ""
    }
    
    /// Removes ingredients added
    @objc
    func removeIngredients() {
        ingredients.removeAll()
        ingredientsTextView.text = ""
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
