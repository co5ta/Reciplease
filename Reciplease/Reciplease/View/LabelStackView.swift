//
//  LabelStackView.swift
//  Reciplease
//
//  Created by co5ta on 25/03/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import UIKit

/// Stack view of the recipe labels
class LabelStackView: UIStackView {
    
    /// Picto relative to labels
    var picto = UIImageView()
    /// List of labels
    var labels = UILabel()
    
    /// Initializes with frame to init view from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    /// Initializes a table cell with a NSCoder object
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUpViews()
    }
}

// MARK: - Setup
extension LabelStackView {
    /// Sets up the views
    func setUpViews() {
        axis = .horizontal
        distribution = .fill
        alignment = .center
        spacing = 5
        setUpPicto()
        setUpLabels()
    }
    
    /// Sets up the picto
    private func setUpPicto() {
        addArrangedSubview(picto)
        picto.tintColor = .secondaryLabel
        picto.contentMode = .scaleAspectFit
        setUpPictoContraints()
    }
    
    /// Sets up the labels
    private func setUpLabels() {
        addArrangedSubview(labels)
        labels.font = UIFont.preferredFont(forTextStyle: .footnote)
        labels.textColor = .secondaryLabel
        labels.numberOfLines = 0
        setUpLabelsConstraints()
    }
}

// MARK: - Constraints
extension LabelStackView {
    /// Sets up the picto constraints
    func setUpPictoContraints() {
        picto.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            picto.heightAnchor.constraint(equalToConstant: 20),
            picto.widthAnchor.constraint(equalTo: picto.heightAnchor)
        ])
        
    }
    
    /// Sets up the labels constraints
    func setUpLabelsConstraints() {
        labels.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalTo: labels.heightAnchor)
        ])
    }
}
