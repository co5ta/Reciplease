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
    var textFieldSection: UIView!
    
    /// Label of the textField
    var textFieldLabel: UILabel!
    
    /// TextField to add ingredients
    var textField: UITextField!
    
    /// Bottom border of the textField
    var textFieldBorder: UIView!
    
    /// Button to validate the addition of an ingredient
    var addButton: UIButton!
    
    /// Section of the ingredients list
    var ingredientsSection: UIView!
    
    /// Title of the ingredient section
    var ingredientsTitle: UILabel!
    
    /// TextView which display the ingredients added
    var ingredientsList: UITextView!
    
    /// Button to clear the ingredients list
    var clearButton: UIButton!
    
    /// Button to submit the form
    var submitButton: UIButton!
    
    /// Array of ingredients
    var ingredients = [String]()
}


// MARK: - Methods
extension SearchFormViewController {
    
    /** Setup the views */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Reciplease"
        
        textFieldSection = UIView()
        textFieldSection.backgroundColor = .white
        textFieldSection.layer.cornerRadius = 10
        textFieldSection.layer.borderColor = UIColor.lightGray.cgColor
        textFieldSection.layer.shadowColor = UIColor.lightGray.cgColor
        textFieldSection.layer.shadowOpacity = 0.5
        textFieldSection.layer.shadowOffset = CGSize(width: 1, height: 1)
        textFieldSection.layer.shadowRadius = 7
        textFieldSection.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textFieldSection)
        
        textFieldLabel = UILabel()
        textFieldLabel.text = "What's on your fridge ?"
        textFieldLabel.font.withSize(17)
        textFieldLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        textFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        textFieldSection.addSubview(textFieldLabel)
            
        textField = UITextField()
        textField.placeholder = "Lemon, Cheese, Sausages..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textFieldSection.addSubview(textField)
        
        textFieldBorder = UIView()
        textFieldBorder.backgroundColor = .lightGray
        textFieldBorder.translatesAutoresizingMaskIntoConstraints = false
        textFieldSection.addSubview(textFieldBorder)
        
        addButton = UIButton(type: .system)
        addButton.setTitle("Add", for: .normal)
        addButton.tintColor = .white
        addButton.backgroundColor = Config.globalTintColor
        addButton.layer.cornerRadius = 5
        addButton.translatesAutoresizingMaskIntoConstraints = false
        textFieldSection.addSubview(addButton)
        
        ingredientsSection = UIView()
        ingredientsSection.backgroundColor = .white
        ingredientsSection.layer.borderColor = UIColor.lightGray.cgColor
        ingredientsSection.layer.shadowColor = UIColor.lightGray.cgColor
        ingredientsSection.layer.shadowOpacity = 0.5
        ingredientsSection.layer.shadowOffset = CGSize(width: 1, height: 1)
        ingredientsSection.layer.shadowRadius = 10
        ingredientsSection.layer.cornerRadius = 10
        ingredientsSection.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ingredientsSection)
        
        ingredientsTitle = UILabel()
        ingredientsTitle.text = "Your ingredients :"
        ingredientsTitle.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        ingredientsTitle.translatesAutoresizingMaskIntoConstraints = false
        ingredientsSection.addSubview(ingredientsTitle)
        
        clearButton = UIButton(type: .system)
        clearButton.backgroundColor = Config.cancelButtonColor
        clearButton.setTitleColor(.white, for: .normal)
        clearButton.setTitle("Clear", for: .normal)
        clearButton.layer.cornerRadius = 5
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        ingredientsSection.addSubview(clearButton)
        
        ingredientsList = UITextView()
        ingredientsList.font = UIFont.systemFont(ofSize: 17)
        ingredientsList.text = "- Apple \n- Tomato \n- Eggs"
        ingredientsList.isSelectable = false
        ingredientsList.translatesAutoresizingMaskIntoConstraints = false
        ingredientsSection.addSubview(ingredientsList)
        
        submitButton = UIButton(type: .system)
        submitButton.tintColor = .white
        submitButton.backgroundColor = Config.globalTintColor
        submitButton.setTitle("Search for recipes", for: .normal)
        submitButton.layer.cornerRadius = 5
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        ingredientsSection.addSubview(submitButton)
        
        initContraints()
        initActions()
    }
    
    /** Add constraints on the views */
    func initContraints() {
        NSLayoutConstraint.activate([
            textFieldSection.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor, constant: 30),
            textFieldSection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textFieldSection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textFieldSection.heightAnchor.constraint(equalTo: textFieldSection.widthAnchor, multiplier: 2/5),
            
            textFieldLabel.topAnchor.constraint(equalTo: textFieldSection.topAnchor, constant: 15),
            textFieldLabel.centerXAnchor.constraint(equalTo: textFieldSection.centerXAnchor),
            
            textField.leadingAnchor.constraint(equalTo: textFieldSection.leadingAnchor, constant: 15),
            textField.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -15),
            textField.bottomAnchor.constraint(equalTo: textFieldSection.bottomAnchor, constant: -20),
            
            textFieldBorder.widthAnchor.constraint(equalTo: textField.widthAnchor),
            textFieldBorder.heightAnchor.constraint(equalToConstant: 1),
            textFieldBorder.centerXAnchor.constraint(equalTo: textField.centerXAnchor),
            textFieldBorder.topAnchor.constraint(equalTo: textField.bottomAnchor),
            
            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.widthAnchor.constraint(equalToConstant: 50),
            addButton.bottomAnchor.constraint(equalTo: textFieldBorder.bottomAnchor),
            addButton.trailingAnchor.constraint(equalTo: textFieldSection.trailingAnchor, constant: -15),
            
            ingredientsSection.topAnchor.constraint(equalTo: textFieldSection.bottomAnchor, constant: 30),
            ingredientsSection.leadingAnchor.constraint(equalTo: textFieldSection.leadingAnchor),
            ingredientsSection.trailingAnchor.constraint(equalTo: textFieldSection.trailingAnchor),
            ingredientsSection.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor, constant: -30),
            
            clearButton.heightAnchor.constraint(equalToConstant: 30),
            clearButton.widthAnchor.constraint(equalToConstant: 50),
            clearButton.topAnchor.constraint(equalTo: ingredientsSection.topAnchor, constant: 15),
            clearButton.trailingAnchor.constraint(equalTo: ingredientsSection.trailingAnchor, constant: -15),
            
            ingredientsTitle.centerYAnchor.constraint(equalTo: clearButton.centerYAnchor),
            ingredientsTitle.leadingAnchor.constraint(equalTo: ingredientsSection.leadingAnchor, constant: 15),
            ingredientsTitle.trailingAnchor.constraint(equalTo: clearButton.leadingAnchor),
            
            ingredientsList.topAnchor.constraint(equalTo: ingredientsTitle.topAnchor, constant: 30),
            ingredientsList.leadingAnchor.constraint(equalTo: ingredientsTitle.leadingAnchor),
            ingredientsList.trailingAnchor.constraint(equalTo: ingredientsSection.trailingAnchor),
            ingredientsList.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -30),
            
            submitButton.heightAnchor.constraint(equalTo: submitButton.widthAnchor, multiplier: 1/6),
            submitButton.centerXAnchor.constraint(equalTo: ingredientsSection.centerXAnchor),
            submitButton.leadingAnchor.constraint(equalTo: ingredientsSection.leadingAnchor, constant: 30),
            submitButton.trailingAnchor.constraint(equalTo: ingredientsSection.trailingAnchor, constant: -30),
            submitButton.bottomAnchor.constraint(equalTo: ingredientsSection.bottomAnchor, constant: -30),
        ])
    }
}


// MARK: - Actions
extension SearchFormViewController {
    
    /** Add actions on views */
    func initActions() {
        let tapView = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapView)
        
        addButton.addTarget(self, action: #selector(addIngredient), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(goToSearchResultScreen), for: .touchUpInside)
    }
    
    /** Add an ingredient to the list */
    @objc func addIngredient() {
        guard let ingredient = textField.text, ingredient != "" else { return }
        ingredients.append(ingredient)
        let joinedIngredients = (ingredients.joined(separator: "\n- "))
        ingredientsList.text = "- \(joinedIngredients) "
        textField.text = ""
    }
    
    /** Hide the keyboard when needed */
    @objc func dismissKeyboard() {
        textField.resignFirstResponder()
    }
}


// MARK: - Navigation
extension SearchFormViewController {

    /// Transition to search result screen
    @objc func goToSearchResultScreen() {
        guard ingredients.isEmpty == false else { return }
        let searchResultScreen = RecipeListViewController(mode: .searchResult)
        searchResultScreen.ingredients = ingredients.joined(separator: " ")
        navigationController?.pushViewController(searchResultScreen, animated: true)
    }
}
