// ShimmerImageViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Шиммер ячейки с изображением рецепта
final class ShimmerImageViewCell: UITableViewCell {
    static let identifier = "ShimmerImageViewCell"

    // MARK: - Constants

    private enum Constants {
        static let photoRecipeCornerRadius = 24.0
        static let beginAnimationTimeOffset = 0.33
    }

    // MARK: - Visual Components

    private let titleRecipeLabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let photoRecipeImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Constants.photoRecipeCornerRadius
        return imageView
    }()

    private lazy var titleRecipeLabelGradientLayer = createGradientLayer()
    private lazy var photoRecipeImageViewGradientLayer = createGradientLayer()

    private lazy var gradientLayers = [
        titleRecipeLabelGradientLayer,
        photoRecipeImageViewGradientLayer,
    ]

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

    // MARK: - Life Cycle

    override func layoutSubviews() {
        super.layoutSubviews()
        titleRecipeLabelGradientLayer.frame = contentView.bounds
        photoRecipeImageViewGradientLayer.frame = contentView.bounds
    }

    // MARK: - Public Methods

    func showShimmers() {
        setupTitleRecipeLabelShimmer()
        setupPhotoRecipeImageViewShimmer()
    }

    func removeShimmers() {
        gradientLayers.forEach { $0.removeFromSuperlayer() }
    }

    // MARK: - Private Methods

    private func configureUI() {
        setupViews()
        setupConstraints()
    }

    private func setupTitleRecipeLabelShimmer() {
        titleRecipeLabel.layer.addSublayer(titleRecipeLabelGradientLayer)
        let animationGroup = createAnimationGroup()
        animationGroup.beginTime = 0.0
        titleRecipeLabelGradientLayer.add(animationGroup, forKey: animationGroup.keyPath)
    }

    private func setupPhotoRecipeImageViewShimmer() {
        photoRecipeImageView.layer.addSublayer(photoRecipeImageViewGradientLayer)
        let animationGroup = createAnimationGroup()
        animationGroup.beginTime = 0.0
        photoRecipeImageViewGradientLayer.add(animationGroup, forKey: animationGroup.keyPath)
    }

    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.addSubview(titleRecipeLabel)
        contentView.addSubview(photoRecipeImageView)
    }

    private func setupConstraints() {
        setupTitleRecipeLabelConstraints()
        setupPhotoRecipeImageViewConstraints()
    }

    private func setupTitleRecipeLabelConstraints() {
        NSLayoutConstraint.activate([
            titleRecipeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleRecipeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleRecipeLabel.widthAnchor.constraint(equalToConstant: 350),
            titleRecipeLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }

    private func setupPhotoRecipeImageViewConstraints() {
        NSLayoutConstraint.activate([
            photoRecipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 45),
            photoRecipeImageView.topAnchor.constraint(equalTo: titleRecipeLabel.bottomAnchor, constant: 20),
            photoRecipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -45),
            photoRecipeImageView.widthAnchor.constraint(equalToConstant: 300),
            photoRecipeImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

    private func createAnimationGroup(previousGroup: CABasicAnimation? = nil) -> CABasicAnimation {
        let animDuration: CFTimeInterval = 1.5

        let basicAnimation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.locations))
        basicAnimation.fromValue = [-1.0, -0.5, 0]
        basicAnimation.toValue = [1, 1.5, 2]
        basicAnimation.duration = animDuration
        basicAnimation.beginTime = 0.0
        basicAnimation.repeatCount = .infinity

        if let previousGroup = previousGroup {
            basicAnimation.beginTime = previousGroup.beginTime + Constants.beginAnimationTimeOffset
        }

        return basicAnimation
    }

    private func createGradientLayer() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.startPoint = .init(x: 0, y: 0.5)
        gradient.endPoint = .init(x: 1, y: 0.5)
        gradient.colors = [UIColor.appLightGray.cgColor, UIColor.white.cgColor, UIColor.appLightGray.cgColor]
        gradient.locations = [0, 0.5, 1]
        return gradient
    }
}
