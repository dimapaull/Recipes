// RecipeDetailImageCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с изображением и названием рецепта
final class RecipeDetailImageCell: UITableViewCell {
    static let identifier = "RecipeDetailImageCell"

    // MARK: - Constants

    private enum Constants {
        static let verdanaBoldSize20 = UIFont(name: "Verdana-Bold", size: 20)
        static let circleBackgroundImage = UIImage(named: "circleBackground")
        static let potImage = UIImage(named: "pot")
        static let verdanaSize10 = UIFont(name: "Verdana", size: 10)
        static let timerBackgroundImage = UIImage(named: "timerBackground")
        static let timerImage = UIImage(named: "whiteTimer")
        static let cookingTime = "Cooking time"
        static let photoRecipeCornerRadius = 24.0
        static let cookingMinute = " min"
        static let potChar = " g"
    }

    // MARK: - Visual Components

    private let titleRecipeLabel = {
        let label = UILabel()
        label.font = Constants.verdanaBoldSize20
        label.textAlignment = .center
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

    private let circleBackgroundImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.circleBackgroundImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let potImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.potImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let potCountLabel = {
        let label = UILabel()
        label.font = Constants.verdanaSize10
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timerBackgroundImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.timerBackgroundImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let timerImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.timerImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let cookingTimeLabel = {
        let label = UILabel()
        label.font = Constants.verdanaSize10
        label.textAlignment = .center
        label.textColor = .white
        label.text = Constants.cookingTime
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let cookingCountLabel = {
        let label = UILabel()
        label.font = Constants.verdanaSize10
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let networkService = NetworkService()

    // MARK: - Public Methods

    func configureCell(info: RecipeDetailTest?) {
        titleRecipeLabel.text = info?.label
        guard let url = info?.image, let imageURL = URL(string: url) else { return }
        let proxy = Proxy(service: networkService)
        proxy.getImageFrom(imageURL) { data, _, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else { return }
                self.photoRecipeImageView.image = UIImage(data: data)
            }
        }
        potCountLabel.text = String(Int(info?.totalWeight ?? 0.0)) + String(Constants.potChar)
        cookingCountLabel.text = "\(Int(info?.totalTime ?? 0)) \(Constants.cookingMinute)"
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
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        contentView.addSubview(titleRecipeLabel)
        contentView.addSubview(photoRecipeImageView)
        photoRecipeImageView.addSubview(circleBackgroundImageView)
        circleBackgroundImageView.addSubview(potImageView)
        circleBackgroundImageView.addSubview(potCountLabel)
        photoRecipeImageView.addSubview(timerBackgroundImageView)
        timerBackgroundImageView.addSubview(timerImageView)
        timerBackgroundImageView.addSubview(cookingTimeLabel)
        timerBackgroundImageView.addSubview(cookingCountLabel)
    }

    private func setupConstraints() {
        setupTitleRecipeLabelConstraints()
        setupPhotoRecipeImageViewConstraints()
        setupCircleBackgroundImageViewConstraints()
        setupPotImageViewConstraints()
        setupPotCountLabelConstraints()
        setupTimerBackgroundImageViewConstraints()
        setupTimerImageViewConstraints()
        setupCookingTimeLabelConstraints()
        setupCookingCountLabelConstraints()
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

    private func setupCircleBackgroundImageViewConstraints() {
        NSLayoutConstraint.activate([
            circleBackgroundImageView.topAnchor.constraint(equalTo: photoRecipeImageView.topAnchor, constant: 8),
            circleBackgroundImageView.trailingAnchor.constraint(
                equalTo: photoRecipeImageView.trailingAnchor,
                constant: -6
            ),
            circleBackgroundImageView.widthAnchor.constraint(equalToConstant: 50),
            circleBackgroundImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupPotImageViewConstraints() {
        NSLayoutConstraint.activate([
            potImageView.centerXAnchor.constraint(equalTo: circleBackgroundImageView.centerXAnchor),
            potImageView.topAnchor.constraint(equalTo: circleBackgroundImageView.topAnchor, constant: 7),
            potImageView.widthAnchor.constraint(equalToConstant: 20),
            potImageView.heightAnchor.constraint(equalToConstant: 17)
        ])
    }

    private func setupPotCountLabelConstraints() {
        NSLayoutConstraint.activate([
            potCountLabel.centerXAnchor.constraint(equalTo: circleBackgroundImageView.centerXAnchor),
            potCountLabel.bottomAnchor.constraint(equalTo: circleBackgroundImageView.bottomAnchor, constant: -6.38),
            potCountLabel.heightAnchor.constraint(equalToConstant: 15.63),
            potCountLabel.widthAnchor.constraint(equalToConstant: 39.17)
        ])
    }

    private func setupTimerBackgroundImageViewConstraints() {
        NSLayoutConstraint.activate([
            timerBackgroundImageView.trailingAnchor.constraint(equalTo: photoRecipeImageView.trailingAnchor),
            timerBackgroundImageView.bottomAnchor.constraint(equalTo: photoRecipeImageView.bottomAnchor),
            timerBackgroundImageView.heightAnchor.constraint(equalToConstant: 48),
            timerBackgroundImageView.widthAnchor.constraint(equalToConstant: 124)
        ])
    }

    private func setupTimerImageViewConstraints() {
        NSLayoutConstraint.activate([
            timerImageView.leadingAnchor.constraint(equalTo: timerBackgroundImageView.leadingAnchor, constant: 8),
            timerImageView.centerYAnchor.constraint(equalTo: timerBackgroundImageView.centerYAnchor),
            timerImageView.heightAnchor.constraint(equalToConstant: 25),
            timerImageView.widthAnchor.constraint(equalToConstant: 25)
        ])
    }

    private func setupCookingTimeLabelConstraints() {
        NSLayoutConstraint.activate([
            cookingTimeLabel.trailingAnchor.constraint(equalTo: timerBackgroundImageView.trailingAnchor, constant: -8),
            cookingTimeLabel.topAnchor.constraint(equalTo: timerBackgroundImageView.topAnchor, constant: 10),
            cookingTimeLabel.heightAnchor.constraint(equalToConstant: 15),
            cookingTimeLabel.widthAnchor.constraint(equalToConstant: 83)
        ])
    }

    private func setupCookingCountLabelConstraints() {
        NSLayoutConstraint.activate([
            cookingCountLabel.trailingAnchor.constraint(
                equalTo: timerBackgroundImageView.trailingAnchor,
                constant: -26
            ),
            cookingCountLabel.bottomAnchor.constraint(equalTo: timerBackgroundImageView.bottomAnchor, constant: -8),
            cookingCountLabel.heightAnchor.constraint(equalToConstant: 15),
            cookingCountLabel.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
