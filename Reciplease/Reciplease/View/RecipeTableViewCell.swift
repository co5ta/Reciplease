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
    
    /// Recipe image
    var picture: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    /// Recipe title
    var titleLabel: UILabel = {
        let label = UILabel()
        //label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Recipe informations container
    var infosStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var healthStackView: LabelStackView = {
        let stackView = LabelStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var dietStackView: LabelStackView = {
        let stackView = LabelStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var cautionsStackView: LabelStackView = {
        let stackView = LabelStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        addSubview(infosStackView)
        //infosStackView.addArrangedSubview(titleLabel)
        infosStackView.addArrangedSubview(dietStackView)
        infosStackView.addArrangedSubview(healthStackView)
        infosStackView.addArrangedSubview(cautionsStackView)
    }
    
    /// Defines and activates constraints to place subviews
    func activateConstraints() {
        NSLayoutConstraint.activate([
            picture.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 3/6),
            picture.topAnchor.constraint(equalTo: topAnchor),
            picture.leadingAnchor.constraint(equalTo: leadingAnchor),
            picture.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            //titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: picture.bottomAnchor, multiplier: 1),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: picture.leadingAnchor, multiplier: 1),
            picture.trailingAnchor.constraint(equalToSystemSpacingAfter: titleLabel.trailingAnchor, multiplier: 1),
            
            infosStackView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1),
            infosStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: infosStackView.trailingAnchor, multiplier: 1),
            //bottomAnchor.constraint(equalToSystemSpacingBelow: infosStackView.bottomAnchor, multiplier: 1),
            
            healthStackView.leadingAnchor.constraint(equalTo: infosStackView.leadingAnchor),
            healthStackView.trailingAnchor.constraint(equalTo: infosStackView.trailingAnchor),
            
            dietStackView.leadingAnchor.constraint(equalTo: infosStackView.leadingAnchor),
            dietStackView.trailingAnchor.constraint(equalTo: infosStackView.trailingAnchor),
            
            cautionsStackView.leadingAnchor.constraint(equalTo: infosStackView.leadingAnchor),
            cautionsStackView.trailingAnchor.constraint(equalTo: infosStackView.trailingAnchor),
        ])
    }
    
    /// Transfers data to cell
    func configure(with recipe: Recipe) {
        getPicture(from: recipe.pictureUrl)
        titleLabel.text = recipe.label
        healthStackView.picto.image = UIImage(named: "heart")
        healthStackView.labels.text = recipe.healthLabels.joined(separator: " | ")
        dietStackView.picto.image = UIImage(named: "weight")
        dietStackView.labels.text = recipe.dietLabels.joined(separator: " | ")
        cautionsStackView.picto.image = UIImage(named: "warning")
        cautionsStackView.labels.text = recipe.cautions.joined(separator: " | ")
    }
    
    /// Gets the picture of the recipe
    func getPicture(from pictureUrl: String) {
        let placeholder = UIImage(named: "placeholder")
        let options = ImageLoadingOptions(placeholder: placeholder, transition: .fadeIn(duration: 0.3))
        if let url = URL(string: pictureUrl) {
            Nuke.loadImage(with: url, options: options, into: picture)
        } else {
            picture.image = placeholder
        }
    }
}
