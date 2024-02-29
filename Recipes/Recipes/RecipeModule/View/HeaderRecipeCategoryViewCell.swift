// HeaderRecipeCategoryViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с категорией рецептов
final class HeaderRecipeCategoryViewCell: UICollectionViewCell {
    
    private let textLabel = {
       let label = UILabel()
        label.text = "Recipes"
        label.font = UIFont(name: "Verdana-Bold", size: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static let headerReuseidentifier = "HeaderRecipeCategoryViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
    }
}
