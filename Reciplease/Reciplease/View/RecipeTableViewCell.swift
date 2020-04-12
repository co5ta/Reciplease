//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by co5ta on 22/03/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import UIKit

/// Custom cell which contains the preview of a recipe
class RecipeTableViewCell: UITableViewCell {
    
    /// View which displays the main informations about  the recipe
    var recipePreview = RecipePreview()
    /// Recipe data
    var recipe: Recipe? { didSet {setUpData()} }
    
    /// Initializes a table cell with a style and a reuse identifier and returns it to the caller
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    /// Initializes a table cell with a NSCoder object
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpViews()
    }
}

// MARK: - Setup
extension RecipeTableViewCell {
    
    /// Sets up the views
    func setUpViews() {
        selectionStyle = .none
        contentView.addSubview(recipePreview)
        setUpConstraints()
    }
    
    /// Gives recipe data to the recipe preview
    func setUpData() {
        guard let recipe = recipe else { return }
        recipePreview.recipe = recipe
    }
}

// MARK: - Constraints
extension RecipeTableViewCell {
    
    /// Sets up the constraints
    func setUpConstraints() {
        recipePreview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipePreview.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipePreview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipePreview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recipePreview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            recipePreview.picture.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
}
