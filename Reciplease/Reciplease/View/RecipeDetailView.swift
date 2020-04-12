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
        ingredientsTitleLabel.adjustsFontForContentSizeCategory = true
        ingredientsTitleLabel.text = "Ingredients:"
        ingredientsTitleLabel.textColor = Config.globalTintColor
        setUpIngredientsTitleLabelConstraints()
    }
    
    /// Sets up the ingredients list view
    private func setUpIngredientsTextView() {
        addSubview(ingredientsTextView)
        ingredientsTextView.backgroundColor = .clear
        ingredientsTextView.adjustsFontForContentSizeCategory = true
        ingredientsTextView.isScrollEnabled = false
        ingredientsTextView.isEditable = false
        setUpIngredientsTextViewConstraints()
    }
    
    /// Sets up the get directions button
    private func setUpGetDirectionsButton() {
        addSubview(getDirectionsButton)
        getDirectionsButton.setTitle("Get directions", for: .normal)
        getDirectionsButton.titleLabel?.adjustsFontForContentSizeCategory = true
        getDirectionsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        getDirectionsButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        getDirectionsButton.contentEdgeInsets = UIEdgeInsets(top: 15, left: 5, bottom: 15, right: 5)
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
        NSLayoutConstraint.activate([
            recipePreview.topAnchor.constraint(equalTo: topAnchor),
            recipePreview.leadingAnchor.constraint(equalTo: leadingAnchor),
            recipePreview.trailingAnchor.constraint(equalTo: trailingAnchor),
            recipePreview.picture.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height/2.5))
        ])
    }
    
    /// Sets up the constraints of ingredients title label
    private func setUpIngredientsTitleLabelConstraints() {
        ingredientsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipePreview.bottomAnchor.constraint(
                equalToSystemSpacingBelow: ingredientsTitleLabel.bottomAnchor,
                multiplier: 1),
            ingredientsTitleLabel.leadingAnchor.constraint(
                equalToSystemSpacingAfter: leadingAnchor,
                multiplier: 1),
            trailingAnchor.constraint(
                equalToSystemSpacingAfter: ingredientsTitleLabel.trailingAnchor,
                multiplier: 1)
        ])
    }
    
    /// Sets up the constraints of the ingredients list
    private func setUpIngredientsTextViewConstraints() {
        ingredientsTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ingredientsTextView.topAnchor.constraint(
                equalToSystemSpacingBelow: ingredientsTitleLabel.bottomAnchor,
                multiplier: 2),
            ingredientsTextView.leadingAnchor.constraint(
                equalToSystemSpacingAfter: leadingAnchor,
                multiplier: 1),
            trailingAnchor.constraint(
                equalToSystemSpacingAfter: ingredientsTextView.trailingAnchor,
                multiplier: 1)
        ])
    }
    
    /// Sets up the constraints of the get directions button
    private func setUpGetDirectionsButtonConstraints() {
        getDirectionsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            getDirectionsButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            getDirectionsButton.widthAnchor.constraint(greaterThanOrEqualTo: widthAnchor, multiplier: 0.6),
            getDirectionsButton.topAnchor.constraint(
                equalToSystemSpacingBelow: ingredientsTextView.bottomAnchor,
                multiplier: 5),
            getDirectionsButton.leadingAnchor.constraint(
                greaterThanOrEqualToSystemSpacingAfter: leadingAnchor,
                multiplier: 1),
            trailingAnchor.constraint(
                greaterThanOrEqualToSystemSpacingAfter: getDirectionsButton.trailingAnchor,
                multiplier: 1),
            bottomAnchor.constraint(
                equalToSystemSpacingBelow: getDirectionsButton.bottomAnchor,
                multiplier: 5)
        ])
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
