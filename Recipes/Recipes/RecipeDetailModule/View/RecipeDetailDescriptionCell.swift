// RecipeDetailDescriptionCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с подробным описанием приготовления рецепта
final class RecipeDetailDescriptionCell: UITableViewCell {
    
    static let identifier = "RecipeDetailDescriptionCell"
    
    // MARK: - Constants

    private enum Constants {
        static let verdanaSize14 = UIFont(name: "Verdana", size: 14)
    }

    // MARK: - Visual Components
    
    private let gradientView = {
       let view = UIView()
        view.layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let descriptionLabel = {
        let label = UILabel()
        label.font = Constants.verdanaSize14
        label.textAlignment = .left
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Public Methods

    func configureCell(info: RecipeDetail) {
        descriptionLabel.text = info.description
    }

    // MARK: - Initializators

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }

    // MARK: - Private Methods

    private func configureUI() {
        contentView.backgroundColor = .white
        addMainViewGradient()
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        contentView.addSubview(gradientView)
        contentView.addSubview(descriptionLabel)
    }
    
    private func addMainViewGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.white.cgColor, UIColor.appGradient.cgColor]
        gradient.frame = contentView.bounds
        contentView.layer.insertSublayer(gradient, at: 0)
    }

    private func setupConstraints() {
        setupGradientViewConstraints()
        setupDescriptionLabelConstraints()
    }

    private func setupGradientViewConstraints() {
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: contentView.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupDescriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 27),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -27),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
}
