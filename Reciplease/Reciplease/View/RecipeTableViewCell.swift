//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by co5ta on 22/03/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import UIKit
import Nuke

/// Cell which contains a recipe
class RecipeTableViewCell: UITableViewCell {
    
    /// Recipe title
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Recipe image
    var picture: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        addSubview(picture)
        addSubview(titleLabel)
    }
    
    /// Defines and activates constraints to place subviews
    func activateConstraints() {
        NSLayoutConstraint.activate([
            picture.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 3/5),
            picture.topAnchor.constraint(equalTo: topAnchor),
            picture.leadingAnchor.constraint(equalTo: leadingAnchor),
            picture.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: picture.bottomAnchor, multiplier: 1),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: picture.leadingAnchor, multiplier: 1),
            picture.trailingAnchor.constraint(equalToSystemSpacingAfter: titleLabel.trailingAnchor, multiplier: 1)
        ])
    }
    
    /// Transfers data to cell
    func configure(with recipe: Recipe) {
        titleLabel.text = recipe.label
        getPicture(from: recipe.image)
    }
    
    /// Gets the picture of the recipe
    func getPicture(from pictureURL: String) {
        let placeholder = UIImage(named: "recipe-image-default")
        let options = ImageLoadingOptions(placeholder: placeholder, transition: .fadeIn(duration: 0.3))
        if let url = URL(string: pictureURL) {
            Nuke.loadImage(with: url, options: options, into: picture)
        } else {
            picture.image = placeholder
        }
        
    }
}
