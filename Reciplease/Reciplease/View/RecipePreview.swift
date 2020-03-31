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
    
    /// Recipe data
    var recipe: Recipe? {
        didSet { setUpViews() }
    }
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
    }
    
    /// Initializes with coder to init view from xib or storyboard
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Setup
extension RecipePreview {
    
    /// Sets up the views
    private func setUpViews() {
        backgroundColor = .white
        guard let recipe = recipe else { return }
        setUpPicture()
        setUpTitle()
        setUpInfosStackView()
        setUpHealthStackView(with: recipe.healthLabels)
        setUpCautionsStackView(with: recipe.cautionLabels)
        setUpData(from: recipe)
    }
    
    /// Sets up the picture of the recipe
    private func setUpPicture() {
        addSubview(picture)
        picture.contentMode = .scaleAspectFill
        picture.clipsToBounds = true
        setUpPictureConstraints()
    }
    
    /// Sets up the title of the recipe
   private  func setUpTitle() {
        addSubview(titleLabel)
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        setUpTitleLabelConstraints()
    }
    
    /// Sets up the stack view for  all recipe labels
    private func setUpInfosStackView() {
        addSubview(infosStackView)
        infosStackView.axis = .vertical
        infosStackView.alignment = .leading
        infosStackView.distribution = .fill
        infosStackView.spacing = 5
        setUpInfosStackViewConstraints()
    }
    
    /// Sets up the stack view for health labels
    private func setUpHealthStackView(with labels: [String]) {
        infosStackView.addArrangedSubview(healthStackView)
        setUpHealthStackViewConstraints()
    }
    
    /// Sets up the stack view for cautions labels
    private func setUpCautionsStackView(with labels: [String]) {
        infosStackView.addArrangedSubview(cautionsStackView)
        setUpCautionsStackViewConstraints()
    }
}

// MARK: - Constraints
extension RecipePreview {
    
    /// Sets up constraints for the picture
    private func setUpPictureConstraints() {
        picture.translatesAutoresizingMaskIntoConstraints = false
        picture.topAnchor.constraint(equalTo: topAnchor).isActive = true
        picture.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        picture.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    /// Sets up constraints for the title
    private func setUpTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalToSystemSpacingBelow:
            picture.bottomAnchor, multiplier: 1).isActive = true
        titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter:
            picture.leadingAnchor, multiplier: 1).isActive = true
        picture.trailingAnchor.constraint(equalToSystemSpacingAfter:
            titleLabel.trailingAnchor, multiplier: 1).isActive = true
    }
    
    /// Sets up constraints for the infos stack view
    private func setUpInfosStackViewConstraints() {
        infosStackView.translatesAutoresizingMaskIntoConstraints = false
        infosStackView.topAnchor.constraint(equalToSystemSpacingBelow:
            titleLabel.bottomAnchor, multiplier: 1).isActive = true
        infosStackView.leadingAnchor.constraint(equalToSystemSpacingAfter:
            leadingAnchor, multiplier: 1).isActive = true
        trailingAnchor.constraint(equalToSystemSpacingAfter:
            infosStackView.trailingAnchor, multiplier: 1).isActive = true
        bottomAnchor.constraint(equalToSystemSpacingBelow:
            infosStackView.bottomAnchor, multiplier: 9).isActive = true
    }
    
    /// Sets up constraints for the health stack view
    private func setUpHealthStackViewConstraints() {
        healthStackView.translatesAutoresizingMaskIntoConstraints = false
        healthStackView.leadingAnchor.constraint(equalTo: infosStackView.leadingAnchor).isActive = true
        healthStackView.trailingAnchor.constraint(equalTo: infosStackView.trailingAnchor).isActive = true
    }
    
    /// Sets up constraints for the cautions stack view
    private func setUpCautionsStackViewConstraints() {
        cautionsStackView.translatesAutoresizingMaskIntoConstraints = false
        cautionsStackView.leadingAnchor.constraint(equalTo:
            infosStackView.leadingAnchor).isActive = true
        cautionsStackView.trailingAnchor.constraint(equalTo:
            infosStackView.trailingAnchor).isActive = true
    }
}

// MARK: - Data
extension RecipePreview {

    /// Sets up the data
    private func setUpData(from recipe: Recipe) {
        getPicture(from: recipe.pictureUrl)
        titleLabel.text = recipe.title
        fill(stackView: healthStackView, withPicto: "heart", andLabels: recipe.healthLabels)
        fill(stackView: cautionsStackView, withPicto: "warning", andLabels: recipe.cautionLabels)
    }
    
    /// Fills a label stackview or remove it if no data available
    private func fill(stackView: LabelStackView, withPicto picto: String, andLabels labels: [String]) {
        if labels.isEmpty {
            stackView.removeFromSuperview()
        } else {
            stackView.picto.image = UIImage(named: picto)
            stackView.labels.text = labels.joined(separator: " | ")
        }
        
    }
    
    /// Gets the picture of the recipe
    private func getPicture(from pictureUrl: String) {
        let placeholder = UIImage(named: "placeholder")
        let options = ImageLoadingOptions(placeholder: placeholder, transition: .fadeIn(duration: 0.3))
        if let url = URL(string: pictureUrl) {
            Nuke.loadImage(with: url, options: options, into: picture)
        } else {
            picture.image = placeholder
        }
    }
}
