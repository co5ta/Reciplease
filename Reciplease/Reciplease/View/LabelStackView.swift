//
//  LabelStackView.swift
//  Reciplease
//
//  Created by co5ta on 25/03/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import UIKit

class LabelStackView: UIStackView {
    
    var picto: UIImageView = {
       let picto = UIImageView()
        picto.contentMode = .scaleAspectFit
        return picto
    }()
    
    var labels: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: .zero)
        configure()
        addViews()
        activateContraints()
    }
    
    func configure() {
        axis = .horizontal
        distribution = .fill
        alignment = .center
        spacing = 5
    }
    
    func addViews() {
        addArrangedSubview(picto)
        addArrangedSubview(labels)
    }
    
    func activateContraints() {
        NSLayoutConstraint.activate([
            picto.heightAnchor.constraint(equalToConstant: 20),
            picto.widthAnchor.constraint(equalTo: picto.heightAnchor)
        ])
    }
}
