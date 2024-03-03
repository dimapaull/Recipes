// RecipeDetailDescriptionCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с подробным описанием приготовления рецепта
final class RecipeDetailDescriptionCell: UITableViewCell {
    static let identifier = "RecipeDetailDescriptionCell"

    // MARK: - Constants

    private enum Constants {
        static let verdanaSize14 = UIFont(name: "Verdana", size: 14)
        static let zero = 0
    }

    // MARK: - Visual Components

    private let gradientView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let descriptionLabel = {
        let label = UILabel()
        label.font = Constants.verdanaSize14
        label.textAlignment = .left
        label.numberOfLines = Constants.zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let gradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.appGradient.cgColor, UIColor.white.cgColor]
        return gradientLayer
    }()

    // MARK: - Public Methods

    func configureCell(info: RecipeDetail?) {
        descriptionLabel.text = info?.description
    }

    // MARK: - Initializators

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradientLayer.frame = gradientView.bounds
    }

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
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        gradientView.layer.addSublayer(gradientLayer)
        contentView.addSubview(gradientView)
        contentView.addSubview(descriptionLabel)
    }

    private func setupConstraints() {
        setupGradientViewConstraints()
        setupDescriptionLabelConstraints()
    }

    private func setupGradientViewConstraints() {
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -15),
            gradientView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20)
        ])
    }

    private func setupDescriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 27),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -27),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -27)
        ])
    }
}
