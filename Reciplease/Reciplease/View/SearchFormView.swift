//
//  SearchFormView.swift
//  Reciplease
//
//  Created by co5ta on 12/04/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import UIKit

/// Search form to search some recipes
class SearchFormView: UIView {

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

    /// Initializes with frame to init view from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    /// Initializes with coder to init view from xib or storyboard
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpViews()
    }
}

// MARK: - Setup
extension SearchFormView {
    
    /// Sets up the views
    private func setUpViews() {
        setUpTextFieldSection()
        setUpTextFieldLabel()
        setUpAddButton()
        setUpTextField()
        setUpTextFieldBorder()
        setUpIngredientsView()
        setUpIngredientsTitle()
        setUpIngredientsList()
        setUpClearButton()
        setUpSubmitButton()
    }
    
    /// Sets up the text field section
    private func setUpTextFieldSection() {
        addSubview(textFieldView)
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
        addSubview(textFieldLabel)
        textFieldLabel.text = Strings.textFieldLabel
        textFieldLabel.numberOfLines = 0
        textFieldLabel.adjustsFontForContentSizeCategory = true
        textFieldLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        setUpTextFieldLabelConstraints()
    }
    
    /// Sets up the add button
    private func setUpAddButton() {
        addSubview(addButton)
        addButton.setTitle(Strings.add, for: .normal)
        addButton.tintColor = .white
        addButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        addButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        addButton.titleLabel?.adjustsFontForContentSizeCategory = true
        addButton.titleLabel?.textAlignment = .center
        addButton.backgroundColor = Config.globalTintColor
        addButton.layer.cornerRadius = 5
        setUpAddButtonConstraints()
    }
    
    /// Sets up the text field
    private func setUpTextField() {
        addSubview(textField)
        textField.placeholder = Strings.textFieldPlaceholder
        setUpTextFieldConstraints()
    }
    
    /// Sets up the text field border
    private func setUpTextFieldBorder() {
        addSubview(textFieldBorder)
        textFieldBorder.backgroundColor = .opaqueSeparator
        setUpTextFieldBorderConstraints()
    }
    
    /// Sets up the ingredients section
    private func setUpIngredientsView() {
        addSubview(ingredientsView)
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
        addSubview(ingredientsTitleLabel)
        ingredientsTitleLabel.text = Strings.userIngredientsTitleLabel
        ingredientsTitleLabel.numberOfLines = 0
        ingredientsTitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        ingredientsTitleLabel.adjustsFontForContentSizeCategory = true
        setUpIngredientsTitleLabelConstraints()
    }
    
    /// Sets up the ingredients list
    private func setUpIngredientsList() {
        addSubview(ingredientsList)
        ingredientsList.font = UIFont.preferredFont(forTextStyle: .body)
        ingredientsList.backgroundColor = .tertiarySystemBackground
        ingredientsList.adjustsFontForContentSizeCategory = true
        ingredientsList.isSelectable = false
        ingredientsList.isScrollEnabled = false
        setUpIngredientsListConstraints()
    }
    
    /// Sets up the clear button
    private func setUpClearButton() {
        addSubview(clearButton)
        clearButton.tintColor = .white
        clearButton.backgroundColor = UIColor.systemGray
        clearButton.setTitle(Strings.cancel, for: .normal)
        clearButton.titleLabel?.adjustsFontForContentSizeCategory = true
        clearButton.titleLabel?.adjustsFontSizeToFitWidth = true
        clearButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        clearButton.layer.cornerRadius = 5
        clearButton.contentEdgeInsets = UIEdgeInsets(top: 15, left: 1, bottom: 15, right: 1)
        setUpClearButtonConstraints()
    }
    
    /// Sets up the submit button
    private func setUpSubmitButton() {
        addSubview(submitButton)
        submitButton.tintColor = .white
        submitButton.backgroundColor = Config.globalTintColor
        submitButton.setTitle(Strings.search, for: .normal)
        submitButton.titleLabel?.adjustsFontForContentSizeCategory = true
        submitButton.titleLabel?.adjustsFontSizeToFitWidth = true
        submitButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        submitButton.layer.cornerRadius = 5
        submitButton.contentEdgeInsets = UIEdgeInsets(top: 15, left: 1, bottom: 15, right: 1)
        setUpSubmitButtonConstraints()
    }
}

// MARK: - Constraints
extension SearchFormView {
      
    /// Sets up constraints for the text field section
    private func setUpTextFieldViewConstraints() {
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textFieldView.topAnchor.constraint(
                equalToSystemSpacingBelow: topAnchor,
                multiplier: 3),
            textFieldView.leadingAnchor.constraint(
                equalToSystemSpacingAfter: leadingAnchor,
                multiplier: 2),
            trailingAnchor.constraint(
                equalToSystemSpacingAfter: textFieldView.trailingAnchor,
                multiplier: 2)
        ])
    }
    
    /// Sets up constraints for the text field label
    private func setUpTextFieldLabelConstraints() {
        textFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textFieldLabel.topAnchor.constraint(
                equalToSystemSpacingBelow: textFieldView.topAnchor,
                multiplier: 2),
            textFieldLabel.leadingAnchor.constraint(
                equalToSystemSpacingAfter: textFieldView.leadingAnchor,
                multiplier: 2),
            textFieldView.trailingAnchor.constraint(
                equalToSystemSpacingAfter: textFieldLabel.trailingAnchor,
                multiplier: 1)
        ])
    }
    
    /// Sets up constraints for add button
    private func setUpAddButtonConstraints() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 45),
            addButton.topAnchor.constraint(
                equalToSystemSpacingBelow: textFieldLabel.bottomAnchor,
                multiplier: 2),
            textFieldView.trailingAnchor.constraint(
                equalToSystemSpacingAfter: addButton.trailingAnchor,
                multiplier: 2),
            textFieldView.bottomAnchor.constraint(
                equalToSystemSpacingBelow: addButton.bottomAnchor,
                multiplier: 2)
        ])
    }
    
    /// Sets up constraints for the text field
    private func setUpTextFieldConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: addButton.topAnchor),
            textField.leadingAnchor.constraint(
                equalToSystemSpacingAfter: textFieldView.leadingAnchor,
                multiplier: 2),
            addButton.leadingAnchor.constraint(
                equalToSystemSpacingAfter: textField.trailingAnchor,
                multiplier: 2),
        ])
    }
    
    /// Sets up constraints for the text field border
    private func setUpTextFieldBorderConstraints() {
        textFieldBorder.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textFieldBorder.heightAnchor.constraint(equalToConstant: 1),
            textFieldBorder.widthAnchor.constraint(equalTo: textField.widthAnchor),
            textFieldBorder.centerXAnchor.constraint(equalTo: textField.centerXAnchor),
            textFieldBorder.topAnchor.constraint(equalTo: textField.bottomAnchor),
            addButton.bottomAnchor.constraint(
                equalToSystemSpacingBelow: textFieldBorder.bottomAnchor,
                multiplier: 0.1),
        ])
    }
    
    /// Sets up constraints for the ingredients section
    private func setUpIngredientsViewConstraints() {
        ingredientsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ingredientsView.topAnchor.constraint(
                equalToSystemSpacingBelow: textFieldView.bottomAnchor,
                multiplier: 3),
            ingredientsView.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor),
            ingredientsView.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor),
            bottomAnchor.constraint(
                equalToSystemSpacingBelow: ingredientsView.bottomAnchor,
                multiplier: 3),
        ])
    }
    
    /// Sets up constraints for the ingredients title
    private func setUpIngredientsTitleLabelConstraints() {
        ingredientsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ingredientsTitleLabel.topAnchor.constraint(
                equalToSystemSpacingBelow: ingredientsView.topAnchor,
                multiplier: 2),
            ingredientsTitleLabel.leadingAnchor.constraint(
                equalToSystemSpacingAfter: ingredientsView.leadingAnchor,
                multiplier: 2),
            ingredientsView.trailingAnchor.constraint(
                equalToSystemSpacingAfter: ingredientsTitleLabel.trailingAnchor,
                multiplier: 2),
            
        ])
    }
    
    /// Sets up constraints for the ingredients list
    private func setUpIngredientsListConstraints() {
        ingredientsList.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ingredientsList.topAnchor.constraint(
                equalToSystemSpacingBelow: ingredientsTitleLabel.bottomAnchor,
                multiplier: 2),
            ingredientsList.leadingAnchor.constraint(equalTo: ingredientsTitleLabel.leadingAnchor),
            ingredientsView.trailingAnchor.constraint(
                equalToSystemSpacingAfter: ingredientsList.trailingAnchor,
                multiplier: 2)
        ])
    }
    
    /// Sets up constraints for the clear button
    private func setUpClearButtonConstraints() {
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = clearButton.topAnchor.constraint(
                equalToSystemSpacingBelow: ingredientsList.bottomAnchor,
                multiplier: 2)
        topConstraint.priority = UILayoutPriority(rawValue: 1)
        NSLayoutConstraint.activate([
            topConstraint,
            clearButton.leadingAnchor.constraint(
                equalToSystemSpacingAfter: ingredientsView.leadingAnchor,
                multiplier: 2),
            ingredientsView.bottomAnchor.constraint(
                equalToSystemSpacingBelow: clearButton.bottomAnchor,
                multiplier: 2)
        ])
    }
    
    /// Sets up constraints for the submit button
    private func setUpSubmitButtonConstraints() {
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            submitButton.heightAnchor.constraint(equalTo: clearButton.heightAnchor),
            submitButton.widthAnchor.constraint(equalTo: clearButton.widthAnchor),
            submitButton.leadingAnchor.constraint(
                equalToSystemSpacingAfter: clearButton.trailingAnchor,
                multiplier: 2),
            ingredientsView.trailingAnchor.constraint(
                equalToSystemSpacingAfter: submitButton.trailingAnchor,
                multiplier: 2),
            submitButton.bottomAnchor.constraint(equalTo: clearButton.bottomAnchor),
        ])
    }
}
