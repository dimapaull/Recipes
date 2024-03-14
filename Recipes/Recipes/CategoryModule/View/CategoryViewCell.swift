// CategoryViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с рецептом
final class CategoryViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let timerRecipeImage = UIImage(named: "timerRecipeImage")
        static let caloryRecipeImage = UIImage(named: "kalRecipeImage")
        static let pointerImage = UIImage(named: "largePointer")
        static let verdanaSize14 = UIFont(name: "Verdana", size: 14)
        static let verdanaSize12 = UIFont(name: "Verdana", size: 12)
        static let timeText = "min"
        static let foodSuplyText = "kcal"
        static let photoRecipeCornerRadius = 12.0
        static let titleRecipeLinesCount = 3
        static let beginAnimationTimeOffset = 0.33
    }

    // MARK: - Visual Components

    private var photoRecipeImage = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = Constants.photoRecipeCornerRadius
        return imageView
    }()

    private let titleRecipeLabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.font = Constants.verdanaSize14
        label.textAlignment = .left
        label.numberOfLines = Constants.titleRecipeLinesCount
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timerRecipeImage = {
        let imageView = UIImageView()
        imageView.image = Constants.timerRecipeImage
        return imageView
    }()

    private let timeRecipeLabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.font = Constants.verdanaSize12
        label.textAlignment = .left
        return label
    }()

    private let caloriesRecipeImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.caloryRecipeImage
        return imageView
    }()

    private let caloriesRecipeLabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.font = Constants.verdanaSize12
        label.textAlignment = .left
        return label
    }()

    private let pointerRecipeImage = {
        let imageView = UIImageView()
        imageView.image = Constants.pointerImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var timeStackView = {
        let stackView = UIStackView(arrangedSubviews: [timerRecipeImage, timeRecipeLabel])
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.clipsToBounds = true
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var caloriesStackView = {
        let stackView = UIStackView(arrangedSubviews: [caloriesRecipeImageView, caloriesRecipeLabel])
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.clipsToBounds = true
        stackView.spacing = 2
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var imageViewGradientLayer = createGradientLayer()
    private lazy var titleLabelGradientLayer = createGradientLayer()
    private lazy var timeStackViewGradientLayer = createGradientLayer()
    private lazy var caloriesStackViewGradientLayer = createGradientLayer()

    private lazy var gradientLayers = [
        imageViewGradientLayer,
        titleLabelGradientLayer,
        timeStackViewGradientLayer,
        caloriesStackViewGradientLayer
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
        imageViewGradientLayer.frame = contentView.bounds
        titleLabelGradientLayer.frame = contentView.bounds
        timeStackViewGradientLayer.frame = contentView.bounds
        caloriesStackViewGradientLayer.frame = contentView.bounds
    }

    // MARK: - Public Methods

    func configureCell(info: Recipe?) {
        setupImage(info?.image)
        titleRecipeLabel.text = info?.label
        timeRecipeLabel.text = "\(Int(info?.totalTime ?? 0)) \(Constants.timeText)"
        caloriesRecipeLabel.text = "\(Int(info?.calories ?? 0)) \(Constants.foodSuplyText)"
    }

    func showShimmers() {
        setupImageViewShimmer()
        setupTitleLabelShimmer()
        setupTimeStackViewShimmer()
        setupCaloriesStackViewShimmer()
    }

    func removeShimmers() {
        gradientLayers.forEach { $0.removeFromSuperlayer() }
    }

    // MARK: - Private Methods

    private func setupImage(_ url: String?) {
        guard let imageUrl = url else { return }
        NetworkService.downLoadImage(imageUrl) { result in
            switch result {
            case let .success(success):
                DispatchQueue.main.async {
                    self.photoRecipeImage.image = success
                }
            case .failure:
                break
            }
        }
    }

    private func configureUI() {
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        setupViews()
        setupConstraints()
    }

    private func setupImageViewShimmer() {
        photoRecipeImage.layer.addSublayer(imageViewGradientLayer)
        let animationGroup = createAnimationGroup()
        animationGroup.beginTime = 0.0
        imageViewGradientLayer.add(animationGroup, forKey: animationGroup.keyPath)
    }

    private func setupTitleLabelShimmer() {
        titleRecipeLabel.layer.addSublayer(titleLabelGradientLayer)
        let animationGroup = createAnimationGroup()
        animationGroup.beginTime = 0.0
        titleLabelGradientLayer.add(animationGroup, forKey: animationGroup.keyPath)
    }

    private func setupTimeStackViewShimmer() {
        timeStackView.layer.addSublayer(timeStackViewGradientLayer)
        let animationGroup = createAnimationGroup()
        animationGroup.beginTime = 0.0
        timeStackViewGradientLayer.add(animationGroup, forKey: animationGroup.keyPath)
    }

    private func setupCaloriesStackViewShimmer() {
        caloriesStackView.layer.addSublayer(caloriesStackViewGradientLayer)
        let animationGroup = createAnimationGroup()
        animationGroup.beginTime = 0.0
        caloriesStackViewGradientLayer.add(animationGroup, forKey: animationGroup.keyPath)
    }

    private func setupViews() {
        contentView.backgroundColor = .appLightGray
        contentView.layer.cornerRadius = 12
        contentView.addSubview(photoRecipeImage)
        contentView.addSubview(timeStackView)
        contentView.addSubview(caloriesStackView)
        contentView.addSubview(titleRecipeLabel)
        contentView.addSubview(pointerRecipeImage)
    }

    private func setupConstraints() {
        setupPhotoRecipeImageConstraints()
        setupTitleRecipeLabelConstraints()
        setupTimeStackViewConstraints()
        setupCaloriesStackViewConstraints()
        setupPointerRecipeImageConstraints()
    }

    private func setupTimeStackViewConstraints() {
        NSLayoutConstraint.activate([
            timeStackView.leadingAnchor.constraint(equalTo: photoRecipeImage.trailingAnchor, constant: 20),
            timeStackView.heightAnchor.constraint(equalToConstant: 15),
            timeStackView.widthAnchor.constraint(equalToConstant: 80),
            timeStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -23),
        ])
    }

    private func setupCaloriesStackViewConstraints() {
        NSLayoutConstraint.activate([
            caloriesStackView.leadingAnchor.constraint(equalTo: timeStackView.trailingAnchor, constant: 10),
            caloriesStackView.heightAnchor.constraint(equalToConstant: 15),
            caloriesStackView.widthAnchor.constraint(equalToConstant: 91),
            caloriesStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -23)
        ])
    }

    private func setupPhotoRecipeImageConstraints() {
        NSLayoutConstraint.activate([
            photoRecipeImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            photoRecipeImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            photoRecipeImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            photoRecipeImage.heightAnchor.constraint(equalToConstant: 80),
            photoRecipeImage.widthAnchor.constraint(equalToConstant: 80)
        ])
    }

    private func setupTitleRecipeLabelConstraints() {
        NSLayoutConstraint.activate([
            titleRecipeLabel.leadingAnchor.constraint(equalTo: photoRecipeImage.trailingAnchor, constant: 20),
            titleRecipeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            titleRecipeLabel.heightAnchor.constraint(equalToConstant: 32),
            titleRecipeLabel.widthAnchor.constraint(equalToConstant: 190)
        ])
    }

    private func setupPointerRecipeImageConstraints() {
        NSLayoutConstraint.activate([
            pointerRecipeImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15.42),
            pointerRecipeImage.centerYAnchor.constraint(equalTo: photoRecipeImage.centerYAnchor),
            pointerRecipeImage.heightAnchor.constraint(equalToConstant: 20),
            pointerRecipeImage.widthAnchor.constraint(equalToConstant: 12.35)
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
