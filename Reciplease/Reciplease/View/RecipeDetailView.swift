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
    
    /// Recipe preview content
    var recipePreview = RecipePreview()
    /// Title before ingredients list
    var ingredientsTitleLabel = UILabel()
    /// Ingredients list
    var ingredientsTextView = UITextView()
    /// Button to show the recipe directions
    var getDirectionsButton = UIButton()
    /// Recipe data
    var recipe: Recipe? { didSet {setUpData()} }
    

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
extension RecipeDetailView {
    /// Sets up the views
    func setUpViews() {
        setUpRecipePreview()
        setUpIngredientsTitleLabel()
        setUpIngredientsTextView()
        setUpGetDirectionsButton()
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
        ingredientsTitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        ingredientsTitleLabel.text = "Ingredients:"
        ingredientsTitleLabel.textColor = Config.globalTintColor
        setUpIngredientsTitleLabelConstraints()
    }
    
    /// Sets up the ingredients list view
    private func setUpIngredientsTextView() {
        addSubview(ingredientsTextView)
        ingredientsTextView.backgroundColor = .clear
        ingredientsTextView.isScrollEnabled = false
        ingredientsTextView.isEditable = false
        setUpIngredientsTextViewConstraints()
    }
    
    /// Sets up the get directions button
    private func setUpGetDirectionsButton() {
        addSubview(getDirectionsButton)
        getDirectionsButton.setTitle("Get directions", for: .normal)
        getDirectionsButton.tintColor = .white
        getDirectionsButton.backgroundColor = Config.globalTintColor
        getDirectionsButton.layer.cornerRadius = 5
        setUpGetDirectionsButtonConstraints()
    }
}

// MARK: - Constraints
extension RecipeDetailView {
    
    /// Sets up the constraints of the recipe preview
    private func setUpRecipePreviewConstraints() {
        recipePreview.translatesAutoresizingMaskIntoConstraints = false
        recipePreview.topAnchor.constraint(equalTo:
            topAnchor).isActive = true
        recipePreview.leadingAnchor.constraint(equalTo:
            leadingAnchor).isActive = true
        recipePreview.trailingAnchor.constraint(equalTo:
            trailingAnchor).isActive = true
        recipePreview.picture.heightAnchor.constraint(equalToConstant:
            (UIScreen.main.bounds.height/2.5)).isActive = true
    }
    
    /// Sets up the constraints of ingredients title label
    private func setUpIngredientsTitleLabelConstraints() {
        ingredientsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
       recipePreview.bottomAnchor.constraint(equalToSystemSpacingBelow:
            ingredientsTitleLabel.bottomAnchor, multiplier: 1).isActive = true
        ingredientsTitleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter:
            leadingAnchor, multiplier: 1).isActive = true
        trailingAnchor.constraint(equalToSystemSpacingAfter:
            ingredientsTitleLabel.trailingAnchor, multiplier: 1).isActive = true
    }
    
    /// Sets up the constraints of the ingredients list
    private func setUpIngredientsTextViewConstraints() {
        ingredientsTextView.translatesAutoresizingMaskIntoConstraints = false
        ingredientsTextView.topAnchor.constraint(equalToSystemSpacingBelow:
            ingredientsTitleLabel.bottomAnchor, multiplier: 2).isActive = true
        ingredientsTextView.leadingAnchor.constraint(equalToSystemSpacingAfter:
            leadingAnchor, multiplier: 1).isActive = true
        trailingAnchor.constraint(equalToSystemSpacingAfter:
            ingredientsTextView.trailingAnchor, multiplier: 1).isActive = true
    }
    
    /// Sets up the constraints of the get directions button
    private func setUpGetDirectionsButtonConstraints() {
        getDirectionsButton.translatesAutoresizingMaskIntoConstraints = false
        getDirectionsButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        getDirectionsButton.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow:
            ingredientsTextView.bottomAnchor, multiplier: 5).isActive = true
        getDirectionsButton.leadingAnchor.constraint(equalToSystemSpacingAfter:
            leadingAnchor, multiplier: 7).isActive = true
        trailingAnchor.constraint(equalToSystemSpacingAfter:
            getDirectionsButton.trailingAnchor, multiplier: 7).isActive = true
        bottomAnchor.constraint(equalToSystemSpacingBelow:
            getDirectionsButton.bottomAnchor, multiplier: 5).isActive = true
    }
}

// MARK: - Data
extension RecipeDetailView {

    /// Fetchs the recipe data
    func setUpData() {
        guard let recipe = recipe else { return }
        recipePreview.recipe = recipe
        formatIngredientsList(recipe: recipe)
    }
    
    /// Fortmats the ingredients list with bullets
    func formatIngredientsList(recipe: Recipe) {
        let bullet = "•  "
        let ingredients = recipe.ingredients.map { return bullet + $0 }
        var attributes = [NSAttributedString.Key: Any]()
        attributes[.font] = UIFont.preferredFont(forTextStyle: .body)
        attributes[.foregroundColor] = UIColor.label
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = (bullet as NSString).size(withAttributes: attributes).width
        paragraphStyle.paragraphSpacing = 7
        attributes[.paragraphStyle] = paragraphStyle
        let string = ingredients.joined(separator: "\n")
        ingredientsTextView.attributedText = NSAttributedString(string: string, attributes: attributes)
    }
}
