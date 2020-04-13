//
//  LabelStackView.swift
//  Reciplease
//
//  Created by co5ta on 25/03/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import UIKit

/// Stack view of the recipe labels
class LabelStackView: UIView {
    
    /// Picto relative to labels
    var picto = UIImageView()
    /// List of labels
    var labels = UILabel()
    
    /// Initializes with frame to init view from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    /// Initializes with coder to init view from storyboard
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpViews()
    }
}

// MARK: - Setup
extension LabelStackView {
    
    /// Sets up the views
    func setUpViews() {
        setUpPicto()
        setUpLabels()
    }
    
    /// Sets up the labels
    private func setUpLabels() {
        addSubview(labels)
        labels.font = UIFont.preferredFont(forTextStyle: .body)
        labels.adjustsFontForContentSizeCategory = true
        labels.textColor = .secondaryLabel
        labels.numberOfLines = 0
        setUpLabelsConstraints()
    }
    
    /// Sets up the picto
    private func setUpPicto() {
        addSubview(picto)
        picto.tintColor = .secondaryLabel
        picto.contentMode = .scaleAspectFit
        picto.setContentCompressionResistancePriority(.required, for: .horizontal)
        picto.setContentHuggingPriority(.required, for: .horizontal)
        setUpPictoContraints()
    }
}

// MARK: - Constraints
extension LabelStackView {
        
/// Sets up the picto constraints
    func setUpPictoContraints() {
        picto.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            picto.topAnchor.constraint(equalTo: topAnchor),
            picto.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
    
    /// Sets up the labels constraints
    func setUpLabelsConstraints() {
        labels.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labels.topAnchor.constraint(equalTo: picto.topAnchor),
            labels.leadingAnchor.constraint(
            equalToSystemSpacingAfter: picto.trailingAnchor,
            multiplier: 1),
            labels.trailingAnchor.constraint(equalTo: trailingAnchor),
            labels.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
