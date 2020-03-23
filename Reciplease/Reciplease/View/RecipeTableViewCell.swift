//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by co5ta on 22/03/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import UIKit

/// Cell which contains a recipe
class RecipeTableViewCell: UITableViewCell {
    
    /// Components container
    var cellContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Recipe title
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Initializes a table cell with a style and a reuse identifier and returns it to the caller
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubviews()
        activateConstraints()
    }
    
    /// Initializes a table cell with a NSCoder object
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
    }
    
    /// Adds subviews to the table cell
    func addSubviews() {
        addSubview(cellContainer)
        cellContainer.addSubview(titleLabel)
    }
    
    /// Defines and activates constraints to place subviews
    func activateConstraints() {
        NSLayoutConstraint.activate([
            cellContainer.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            cellContainer.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: cellContainer.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: cellContainer.bottomAnchor, multiplier: 1),
            
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: cellContainer.leadingAnchor, multiplier: 2),
            cellContainer.trailingAnchor.constraint(equalToSystemSpacingAfter: titleLabel.trailingAnchor, multiplier: 2),
            cellContainer.bottomAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 2),
        ])
    }
    
    /// Transfers data to cell
    func configure(with recipe: Recipe) {
        titleLabel.text = recipe.label
    }
}
