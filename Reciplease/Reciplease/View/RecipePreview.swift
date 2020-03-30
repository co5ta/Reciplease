//
//  RecipePreview.swift
//  Reciplease
//
//  Created by co5ta on 26/03/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import UIKit
import Nuke

/// Gathers main informations about  the recipe
class RecipePreview: UIView {
    
    /// Recipe image
    var picture = UIImageView()
    /// Recipe title
    var titleLabel = UILabel()
    /// Recipe informations container
    var infosStackView = UIStackView()
    /// List of health labels
    var healthStackView = LabelStackView()
    /// List of cautions labels
    var cautionsStackView = LabelStackView()
    
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
extension RecipePreview {
    
    /// Sets up the views
    func setUpViews() {
        backgroundColor = .white
        setUpPicture()
        setUpTitle()
        setUpInfosStackView()
        setUpHealthStackView()
        setUpCautionsStackView()
    }
    
    /// Sets up the picture of the recipe
    func setUpPicture() {
        picture.contentMode = .scaleAspectFill
        picture.clipsToBounds = true
        addSubview(picture)
        setUpPictureConstraints()
    }
    
    /// Sets up the title of the recipe
    func setUpTitle() {
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        addSubview(titleLabel)
        setUpTitleLabelConstraints()
    }
    
    /// Sets up the stack view for  all recipe labels
    func setUpInfosStackView() {
        infosStackView.axis = .vertical
        infosStackView.alignment = .leading
        infosStackView.distribution = .fill
        infosStackView.spacing = 5
        addSubview(infosStackView)
        setUpInfosStackViewConstraints()
    }
    
    /// Sets up the stack view for health labels
    func setUpHealthStackView() {
        infosStackView.addArrangedSubview(healthStackView)
        setUpHealthStackViewConstraints()
    }
    
    /// Sets up the stack view for cautions labels
    func setUpCautionsStackView() {
        infosStackView.addArrangedSubview(cautionsStackView)
        setUpCautionsStackViewConstraints()
    }
}

// MARK: - Constraints
extension RecipePreview {
    
    /// Sets up constraints for the picture
    func setUpPictureConstraints() {
        picture.translatesAutoresizingMaskIntoConstraints = false
        picture.topAnchor.constraint(equalTo: topAnchor).isActive = true
        picture.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        picture.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    /// Sets up constraints for the title
    func setUpTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalToSystemSpacingBelow:
            picture.bottomAnchor, multiplier: 1).isActive = true
        titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter:
            picture.leadingAnchor, multiplier: 1).isActive = true
        picture.trailingAnchor.constraint(equalToSystemSpacingAfter:
            titleLabel.trailingAnchor, multiplier: 1).isActive = true
    }
    
    /// Sets up constraints for the infos stack view
    func setUpInfosStackViewConstraints() {
        infosStackView.translatesAutoresizingMaskIntoConstraints = false
        infosStackView.topAnchor.constraint(equalToSystemSpacingBelow:
            titleLabel.bottomAnchor, multiplier: 1).isActive = true
        infosStackView.leadingAnchor.constraint(equalToSystemSpacingAfter:
            leadingAnchor, multiplier: 1).isActive = true
        trailingAnchor.constraint(equalToSystemSpacingAfter:
            infosStackView.trailingAnchor, multiplier: 1).isActive = true
//        infosStackView.bottomAnchor.constraint(equalTo:
//            bottomAnchor).isActive = true
    }
    
    /// Sets up constraints for the health stack view
    func setUpHealthStackViewConstraints() {
        healthStackView.translatesAutoresizingMaskIntoConstraints = false
        healthStackView.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        healthStackView.leadingAnchor.constraint(equalTo: infosStackView.leadingAnchor).isActive = true
        healthStackView.trailingAnchor.constraint(equalTo: infosStackView.trailingAnchor).isActive = true
    }
    
    /// Sets up constraints for the cautions stack view
    func setUpCautionsStackViewConstraints() {
        cautionsStackView.translatesAutoresizingMaskIntoConstraints = false
        cautionsStackView.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        cautionsStackView.leadingAnchor.constraint(equalTo: infosStackView.leadingAnchor).isActive = true
        cautionsStackView.trailingAnchor.constraint(equalTo: infosStackView.trailingAnchor).isActive = true
    }
}

// MARK: - Data
extension RecipePreview {
    
    /// Transfers data to cell
    func fetchData(with recipe: Recipe) {
        getPicture(from: recipe.pictureUrl)
        titleLabel.text = recipe.title
        fill(healthStackView, withPicto: "heart", andLabels: recipe.healthLabels)
        fill(cautionsStackView, withPicto: "warning", andLabels: recipe.cautionLabels)
    }
    
    /// Fill a label stackview or remove it if no data available
    func fill(_ stackView: LabelStackView, withPicto picto: String, andLabels labels: [String]) {
        if labels.isEmpty {
            stackView.removeFromSuperview()
        } else {
            stackView.picto.image = UIImage(named: picto)
            stackView.labels.text = labels.joined(separator: " | ")
        }
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
