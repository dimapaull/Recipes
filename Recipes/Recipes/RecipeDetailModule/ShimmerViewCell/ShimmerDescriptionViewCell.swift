// ShimmerDescriptionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Шиммер с детальным описанием рецепта
final class ShimmerDescriptionViewCell: UITableViewCell {
    static let identifier = "ShimmerDescriptionViewCell"

    // MARK: - Constants

    private enum Constants {
        static let beginAnimationTimeOffset = 0.33
        static let one = 1
    }

    // MARK: - Visual Components

    private let gradientView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let gradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.appGradient.cgColor, UIColor.white.cgColor]
        return gradientLayer
    }()

    private let firstView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let secondView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let thirdView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let fourView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let fiveView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var firstViewGradientLayer = createGradientLayer()
    private lazy var secondViewGradientLayer = createGradientLayer()
    private lazy var thirdViewGradientLayer = createGradientLayer()
    private lazy var fourViewGradientLayer = createGradientLayer()
    private lazy var fiveViewGradientLayer = createGradientLayer()

    private lazy var gradientLayers = [
        firstViewGradientLayer,
        secondViewGradientLayer,
        thirdViewGradientLayer,
        fourViewGradientLayer,
        fiveViewGradientLayer
    ]

    private lazy var elementsStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                firstView,
                secondView,
                thirdView,
                fourView,
                fiveView
            ]
        )
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

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

    // MARK: - Life Cycle

    override func layoutSubviews() {
        super.layoutSubviews()
        firstViewGradientLayer.frame = contentView.bounds
        secondViewGradientLayer.frame = contentView.bounds
        thirdViewGradientLayer.frame = contentView.bounds
        fourViewGradientLayer.frame = contentView.bounds
        fiveViewGradientLayer.frame = contentView.bounds
    }

    // MARK: - Public Methods

    func showShimmers() {
        setupFirstViewShimmer()
        setupSecondViewShimmer()
        setupThirdViewShimmer()
        setupFourViewShimmer()
        setupFiveViewShimmer()
    }

    func removeShimmers() {
        gradientLayers.forEach { $0.removeFromSuperlayer() }
    }

    // MARK: - Private Methods

    private func configureUI() {
        setupViews()
        setupConstraints()
    }

    private func setupFirstViewShimmer() {
        firstView.layer.addSublayer(firstViewGradientLayer)
        let animationGroup = createAnimationGroup()
        animationGroup.beginTime = 0.0
        firstViewGradientLayer.add(animationGroup, forKey: animationGroup.keyPath)
    }

    private func setupSecondViewShimmer() {
        secondView.layer.addSublayer(secondViewGradientLayer)
        let animationGroup = createAnimationGroup()
        animationGroup.beginTime = 0.0
        secondViewGradientLayer.add(animationGroup, forKey: animationGroup.keyPath)
    }

    private func setupThirdViewShimmer() {
        thirdView.layer.addSublayer(thirdViewGradientLayer)
        let animationGroup = createAnimationGroup()
        animationGroup.beginTime = 0.0
        thirdViewGradientLayer.add(animationGroup, forKey: animationGroup.keyPath)
    }

    private func setupFourViewShimmer() {
        fourView.layer.addSublayer(fourViewGradientLayer)
        let animationGroup = createAnimationGroup()
        animationGroup.beginTime = 0.0
        fourViewGradientLayer.add(animationGroup, forKey: animationGroup.keyPath)
    }

    private func setupFiveViewShimmer() {
        fiveView.layer.addSublayer(fiveViewGradientLayer)
        let animationGroup = createAnimationGroup()
        animationGroup.beginTime = 0.0
        fiveViewGradientLayer.add(animationGroup, forKey: animationGroup.keyPath)
    }

    private func setupViews() {
        gradientView.layer.addSublayer(gradientLayer)
        contentView.addSubview(gradientView)
        contentView.addSubview(elementsStackView)
    }

    private func setupConstraints() {
        setupGradientViewConstraints()
        setupElementsStackViewConstraints()
    }

    private func setupGradientViewConstraints() {
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: elementsStackView.topAnchor, constant: -25),
            gradientView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20)
        ])
    }

    private func setupElementsStackViewConstraints() {
        NSLayoutConstraint.activate([
            elementsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 37),
            elementsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 27),
            elementsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -27),

            firstView.heightAnchor.constraint(equalToConstant: 16),
            secondView.heightAnchor.constraint(equalToConstant: 16),
            thirdView.heightAnchor.constraint(equalToConstant: 16),
            fourView.heightAnchor.constraint(equalToConstant: 16),
            fiveView.heightAnchor.constraint(equalToConstant: 16),
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
