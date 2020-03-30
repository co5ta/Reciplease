//
//  RecipeDetailView.swift
//  Reciplease
//
//  Created by co5ta on 28/03/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import UIKit

///
class RecipeDetailView: UIView {
    
    /// Recipe data
    var recipe: Recipe?
    /// Recipe preview content
    var recipePreview = RecipePreview()
    /// Title before ingredients list
    var ingredientsTitleLabel = UILabel()
    /// Ingredients list container
    var ingredientsContainer = UIView()
    /// Ingredients list
    var ingredientsTextView = UITextView()
    /// Button to show the recipe directions
    var showRecipeButton = UIButton()
    

    /// /// Initializes with frame to init view from code
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
extension RecipeDetailView {
    /// Sets up the views
    func setUpViews() {
        setUpRecipePreview()
        setUpIngredientsTitleLabel()
        setUpIngredientsContainer()
        setUpIngredientsTextView()
        setUpShowRecipeButton()
    }
    
    /// Sets up the recipe preview
    private func setUpRecipePreview() {
        addSubview(recipePreview)
        recipePreview.titleLabel.numberOfLines = 0
        setUpRecipePreviewConstraints()
    }
    
    /// Sets up the ingredients title label
    private func setUpIngredientsTitleLabel() {
        addSubview(ingredientsTitleLabel)
        ingredientsTitleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        ingredientsTitleLabel.text = "Ingredients:"
        ingredientsTitleLabel.textColor = Config.Color.globalTintColor
        setUpIngredientsTitleLabelConstraints()
    }
    
    /// Sets up the ingredients list container
    private func setUpIngredientsContainer() {
        addSubview(ingredientsContainer)
        setUpIngredientsContainerConstraints()
    }
    
    /// Sets up the ingredients list view
    private func setUpIngredientsTextView() {
        ingredientsContainer.addSubview(ingredientsTextView)
        ingredientsTextView.font = UIFont.preferredFont(forTextStyle: .body)
        ingredientsTextView.isScrollEnabled = false
        ingredientsTextView.isEditable = false
        ingredientsTextView.backgroundColor = .clear
        setUpIngredientsTextViewConstraints()
    }
    
    ///
    private func setUpShowRecipeButton() {
        ingredientsContainer.addSubview(showRecipeButton)
        showRecipeButton.setTitle("Get directions", for: .normal)
        showRecipeButton.tintColor = .white
        showRecipeButton.backgroundColor = Config.Color.globalTintColor
        showRecipeButton.layer.cornerRadius = 5
        setUpShowRecipeButtonConstraints()
    }
}

// MARK: - Constraints
extension RecipeDetailView {
    
    /// Sets up the constraints of the recipe preview
    private func setUpRecipePreviewConstraints() {
        recipePreview.translatesAutoresizingMaskIntoConstraints = false
        //recipePreview.backgroundColor = .green
        recipePreview.heightAnchor.constraint(equalToConstant:
            Config.recipePreviewHeight).isActive = true
        recipePreview.topAnchor.constraint(equalTo:
            topAnchor).isActive = true
        recipePreview.leadingAnchor.constraint(equalTo:
            leadingAnchor).isActive = true
        recipePreview.trailingAnchor.constraint(equalTo:
            trailingAnchor).isActive = true
        recipePreview.picture.heightAnchor.constraint(equalTo:
            recipePreview.heightAnchor, multiplier: 0.5).isActive = true
//        recipePreview.picture.heightAnchor.constraint(equalToConstant:
//            Config.recipePreviewHeight).isActive = true
//        recipePreview.infosStackView.bottomAnchor.constraint(equalTo:
//            recipePreview.bottomAnchor).isActive = true
//
    }
    
    /// Sets up the constraints of ingredients title label
    private func setUpIngredientsTitleLabelConstraints() {
        ingredientsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientsTitleLabel.topAnchor.constraint(equalToSystemSpacingBelow:
            recipePreview.bottomAnchor, multiplier: 4).isActive = true
        ingredientsTitleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter:
            leadingAnchor, multiplier: 1).isActive = true
        trailingAnchor.constraint(equalToSystemSpacingAfter:
            ingredientsTitleLabel.trailingAnchor, multiplier: 1).isActive = true
    }
    
    /// Sets up the constraints of the ingredients list container
    private func setUpIngredientsContainerConstraints() {
        ingredientsContainer.translatesAutoresizingMaskIntoConstraints = false
        ingredientsContainer.topAnchor.constraint(equalToSystemSpacingBelow:
            ingredientsTitleLabel.bottomAnchor, multiplier: 1).isActive = true
        ingredientsContainer.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: ingredientsContainer.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: ingredientsContainer.bottomAnchor).isActive = true
    }
    
    /// Sets up the constraints of the ingredients list
    private func setUpIngredientsTextViewConstraints() {
        ingredientsTextView.translatesAutoresizingMaskIntoConstraints = false
        ingredientsTextView.topAnchor.constraint(equalToSystemSpacingBelow:
            ingredientsContainer.topAnchor, multiplier: 1).isActive = true
        ingredientsTextView.leadingAnchor.constraint(equalToSystemSpacingAfter:
            ingredientsContainer.leadingAnchor, multiplier: 1).isActive = true
        ingredientsContainer.trailingAnchor.constraint(equalToSystemSpacingAfter:
            ingredientsTextView.trailingAnchor, multiplier: 1).isActive = true
//        ingredientsContainer.bottomAnchor.constraint(equalToSystemSpacingBelow:
//            ingredientsTextView.bottomAnchor, multiplier: 2).isActive = true
    }
    
    /// Sets up the constraints of the button which show the recipe
    private func setUpShowRecipeButtonConstraints() {
        showRecipeButton.translatesAutoresizingMaskIntoConstraints = false
        showRecipeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        showRecipeButton.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow:
            ingredientsTextView.bottomAnchor, multiplier: 5).isActive = true
        showRecipeButton.leadingAnchor.constraint(equalToSystemSpacingAfter:
            leadingAnchor, multiplier: 7).isActive = true
        trailingAnchor.constraint(equalToSystemSpacingAfter:
            showRecipeButton.trailingAnchor, multiplier: 7).isActive = true
        ingredientsContainer.bottomAnchor.constraint(equalToSystemSpacingBelow:
            showRecipeButton.bottomAnchor, multiplier: 5).isActive = true
//        bottomAnchor.constraint(equalToSystemSpacingBelow:
//            showRecipeButton.bottomAnchor, multiplier: 3).isActive = true
    }
}

// MARK: - Data
extension RecipeDetailView {

    /// Fetchs the recipe data
    func fetchData(from recipe: Recipe) {
        recipePreview.fetchData(with: recipe)
        ingredientsTextView.text = recipe.ingredients.joined(separator: "\n- ")
    }
}
