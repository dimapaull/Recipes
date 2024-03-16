// ShimmerCompoundViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Шиммер ячейки с составом рецепта
final class ShimmerCompoundViewCell: UITableViewCell {
    static let identifier = "ShimmerCompoundViewCell"

    // MARK: - Constants

    private enum Constants {
        static let backgroundImage = UIImage(named: "backgroundImageCell")
        static let sixteen = 16
        static let beginAnimationTimeOffset = 0.33
    }

    // MARK: - Visual Components

    private let enercKcalImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.backgroundImage
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = CGFloat(Constants.sixteen)
        return imageView
    }()

    private let carbohydratesImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.backgroundImage
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = CGFloat(Constants.sixteen)
        return imageView
    }()

    private let fatsImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.backgroundImage
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = CGFloat(Constants.sixteen)
        return imageView
    }()

    private let proteinsImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.backgroundImage
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = CGFloat(Constants.sixteen)
        return imageView
    }()

    private lazy var enercKcalImageViewGradientLayer = createGradientLayer()
    private lazy var carbohydratesImageViewGradientLayer = createGradientLayer()
    private lazy var fatsImageViewGradientLayer = createGradientLayer()
    private lazy var proteinsImageViewGradientLayer = createGradientLayer()

    private lazy var gradientLayers = [
        enercKcalImageViewGradientLayer,
        carbohydratesImageViewGradientLayer,
        fatsImageViewGradientLayer,
        proteinsImageViewGradientLayer
    ]

    private lazy var elementsStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                enercKcalImageView,
                carbohydratesImageView,
                fatsImageView,
                proteinsImageView
            ]
        )
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

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
        enercKcalImageViewGradientLayer.frame = contentView.bounds
        carbohydratesImageViewGradientLayer.frame = contentView.bounds
        fatsImageViewGradientLayer.frame = contentView.bounds
        proteinsImageViewGradientLayer.frame = contentView.bounds
    }

    // MARK: - Public Methods

    func showShimmers() {
        setupEnercKcalImageViewShimmer()
        setupCarbohydratesImageViewShimmer()
        setupFatsImageViewShimmer()
        setupProteinsImageViewShimmer()
    }

    func removeShimmers() {
        gradientLayers.forEach { $0.removeFromSuperlayer() }
    }

    // MARK: - Private Methods

    private func configureUI() {
        setupViews()
        setupConstraints()
    }

    private func setupEnercKcalImageViewShimmer() {
        enercKcalImageView.layer.addSublayer(enercKcalImageViewGradientLayer)
        let animationGroup = createAnimationGroup()
        animationGroup.beginTime = 0.0
        enercKcalImageViewGradientLayer.add(animationGroup, forKey: animationGroup.keyPath)
    }

    private func setupCarbohydratesImageViewShimmer() {
        carbohydratesImageView.layer.addSublayer(carbohydratesImageViewGradientLayer)
        let animationGroup = createAnimationGroup()
        animationGroup.beginTime = 0.0
        carbohydratesImageViewGradientLayer.add(animationGroup, forKey: animationGroup.keyPath)
    }

    private func setupFatsImageViewShimmer() {
        fatsImageView.layer.addSublayer(fatsImageViewGradientLayer)
        let animationGroup = createAnimationGroup()
        animationGroup.beginTime = 0.0
        fatsImageViewGradientLayer.add(animationGroup, forKey: animationGroup.keyPath)
    }

    private func setupProteinsImageViewShimmer() {
        proteinsImageView.layer.addSublayer(proteinsImageViewGradientLayer)
        let animationGroup = createAnimationGroup()
        animationGroup.beginTime = 0.0
        proteinsImageViewGradientLayer.add(animationGroup, forKey: animationGroup.keyPath)
    }

    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.addSubview(elementsStackView)
    }

    private func setupConstraints() {
        setupElementsStackViewConstraints()
    }

    private func setupElementsStackViewConstraints() {
        NSLayoutConstraint.activate([
            elementsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            elementsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            elementsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            elementsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
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
