// RecipeCategoryViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с категорией рецептов
final class RecipeCategoryViewCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let bottomStripeImage = UIImage(named: "bottomStripe")
        static let verdanaSize20 = UIFont(name: "Verdana", size: 20)
        static let twentyTwo = 22
        static let one = 1
        static let eighteen = 18
    }
    
    // MARK: - Public Properties
    
    static let identifier = "RecipeCategoryViewCell"
    
    // MARK: - Visual Components
    
    let recipeCategoryImage = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = CGFloat(Constants.twentyTwo)
        return imageView
    }()
    
    let bottomStripeImage = {
        let imageView = UIImageView()
        imageView.image = Constants.bottomStripeImage
         imageView.translatesAutoresizingMaskIntoConstraints = false
         return imageView
    }()
    
    let titleRecipeCategoryLabel = {
       let label = UILabel()
        label.font = Constants.verdanaSize20
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = Constants.one
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Public Methods
    
    func configureCell(info: RecipeCategory) {
        recipeCategoryImage.image = UIImage(named: info.recipeCategoryImage)
        titleRecipeCategoryLabel.text = info.recipeCategoryTitle
    }
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }

    // MARK: - Private Methods

    private func setupViews() {

        contentView.layer.cornerRadius = CGFloat(Constants.eighteen)
        contentView.makeShadow()
        contentView.addSubview(recipeCategoryImage)
        recipeCategoryImage.addSubview(bottomStripeImage)
        bottomStripeImage.addSubview(titleRecipeCategoryLabel)
    }
    
    private func setupConstraints() {
        setupRecipeCategoryImageConstraints()
        setupBottomStripeImageConstraints()
        setupTitleRecipeCategoryLabelConstraints()
    }
    
    private func setupRecipeCategoryImageConstraints() {
        NSLayoutConstraint.activate([
            recipeCategoryImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipeCategoryImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeCategoryImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recipeCategoryImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupBottomStripeImageConstraints() {
        NSLayoutConstraint.activate([
            bottomStripeImage.leadingAnchor.constraint(equalTo: recipeCategoryImage.leadingAnchor),
            bottomStripeImage.trailingAnchor.constraint(equalTo: recipeCategoryImage.trailingAnchor),
            bottomStripeImage.bottomAnchor.constraint(equalTo: recipeCategoryImage.bottomAnchor)
        ])
    }
    
    private func setupTitleRecipeCategoryLabelConstraints() {
        NSLayoutConstraint.activate([
            titleRecipeCategoryLabel.centerXAnchor.constraint(equalTo: bottomStripeImage.centerXAnchor),
            titleRecipeCategoryLabel.centerYAnchor.constraint(equalTo: bottomStripeImage.centerYAnchor),
            titleRecipeCategoryLabel.widthAnchor.constraint(equalToConstant: 180),
            titleRecipeCategoryLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
