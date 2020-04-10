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
    /// Recipe data
    var recipe: Recipe? { didSet {setUpViews()} }
    
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
        backgroundColor = .systemBackground
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
        NSLayoutConstraint.activate([
            picture.topAnchor.constraint(equalTo: topAnchor),
            picture.leadingAnchor.constraint(equalTo: leadingAnchor),
            picture.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    /// Sets up constraints for the title
    private func setUpTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalToSystemSpacingBelow: picture.bottomAnchor,
                multiplier: 1),
            titleLabel.leadingAnchor.constraint(
                equalToSystemSpacingAfter: picture.leadingAnchor,
                multiplier: 1),
            picture.trailingAnchor.constraint(
                equalToSystemSpacingAfter: titleLabel.trailingAnchor,
                multiplier: 1)
        ])
    }
    
    /// Sets up constraints for the infos stack view
    private func setUpInfosStackViewConstraints() {
        infosStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infosStackView.topAnchor.constraint(
                equalToSystemSpacingBelow: titleLabel.bottomAnchor,
                multiplier: 1),
            infosStackView.leadingAnchor.constraint(
                equalToSystemSpacingAfter: leadingAnchor,
                multiplier: 1),
            trailingAnchor.constraint(
                equalToSystemSpacingAfter: infosStackView.trailingAnchor,
                multiplier: 1),
            bottomAnchor.constraint(
                equalToSystemSpacingBelow: infosStackView.bottomAnchor,
                multiplier: 9)
        ])
    }
    
    /// Sets up constraints for the health stack view
    private func setUpHealthStackViewConstraints() {
        healthStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            healthStackView.leadingAnchor.constraint(equalTo: infosStackView.leadingAnchor),
            healthStackView.trailingAnchor.constraint(equalTo: infosStackView.trailingAnchor)
        ])
    }
    
    /// Sets up constraints for the cautions stack view
    private func setUpCautionsStackViewConstraints() {
        cautionsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cautionsStackView.leadingAnchor.constraint(equalTo: infosStackView.leadingAnchor),
            cautionsStackView.trailingAnchor.constraint(equalTo: infosStackView.trailingAnchor)
        ])
        
    }
}

// MARK: - Data
extension RecipePreview {

    /// Sets up the data
    private func setUpData(from recipe: Recipe) {
        getPicture(from: recipe.pictureUrl)
        titleLabel.text = recipe.title
        fillStackView(healthStackView, picto: "heart", labels: recipe.healthLabels)
        fillStackView(cautionsStackView, picto: "exclamationmark.circle", labels: recipe.cautionLabels)
    }
    
    /// Fills a label stackview or remove it if no data available
    private func fillStackView(_ stackView: LabelStackView, picto: String, labels: [String]) {
        if labels.isEmpty {
            stackView.removeFromSuperview()
        } else {
            stackView.picto.image = UIImage(systemName: picto)
            stackView.labels.text = labels.joined(separator: " | ")
        }
        
    }
    
    /// Gets the picture of the recipe
    private func getPicture(from pictureUrl: String) {
        let placeholder = UIImage(named: "plate")
        let failureImage = UIImage(named: "failureImage")
        let options = ImageLoadingOptions(
            placeholder: placeholder,
            transition: .fadeIn(duration: 0.3),
            failureImage: failureImage,
            contentModes: .init(success: .scaleAspectFill, failure: .scaleAspectFill, placeholder: .center))
        guard let url = URL(string: pictureUrl) else { picture.image = failureImage; return }
        Nuke.loadImage(with: url, options: options, into: picture)
    }
}
