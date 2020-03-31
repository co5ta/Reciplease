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
        addSubview(recipePreview)
        recipePreview.titleLabel.numberOfLines = 2
        setUpConstraints()
    }
}

// MARK: - Constraints
extension RecipeTableViewCell {
    
    /// Sets up the constraints
    func setUpConstraints() {
        recipePreview.translatesAutoresizingMaskIntoConstraints = false
        recipePreview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        recipePreview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        recipePreview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        recipePreview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        recipePreview.picture.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
}
