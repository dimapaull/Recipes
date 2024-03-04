// CategoryViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с рецептом
final class CategoryViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let timerRecipeImage = UIImage(named: "timerRecipeImage")
        static let kalRecipeImage = UIImage(named: "kalRecipeImage")
        static let pointerImage = UIImage(named: "largePointer")
        static let verdanaSize14 = UIFont(name: "Verdana", size: 14)
        static let verdanaSize12 = UIFont(name: "Verdana", size: 12)
        static let timeText = "min"
        static let foodSuplyText = "kkal"
        static let protoRecipeCornerRadius = 12.0
        static let titleRecipeLinesCount = 2
    }

    // MARK: - Visual Components

    private let photoRecipeImage = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = Constants.protoRecipeCornerRadius
        return imageView
    }()

    private let titleRecipeLabel = {
        let label = UILabel()
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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let timeRecipeLabel = {
        let label = UILabel()
        label.font = Constants.verdanaSize12
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let kalRecipeImage = {
        let imageView = UIImageView()
        imageView.image = Constants.kalRecipeImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let kalRecipeLabel = {
        let label = UILabel()
        label.font = Constants.verdanaSize12
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let pointerRecipeImage = {
        let imageView = UIImageView()
        imageView.image = Constants.pointerImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Public Methods

    func configureCell(info: RecipeDetail?) {
        photoRecipeImage.image = UIImage(named: info?.imageName ?? "")
        titleRecipeLabel.text = info?.title
        timeRecipeLabel.text = "\(info?.cookingTime ?? "") \(Constants.timeText)"
        kalRecipeLabel.text = "\(info?.kilocalories ?? "") \(Constants.foodSuplyText)"
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
        contentView.backgroundColor = .blue
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        contentView.backgroundColor = .appLightGray
        contentView.layer.cornerRadius = 12
        contentView.addSubview(photoRecipeImage)
        contentView.addSubview(titleRecipeLabel)
        contentView.addSubview(timerRecipeImage)
        contentView.addSubview(timeRecipeLabel)
        contentView.addSubview(kalRecipeImage)
        contentView.addSubview(kalRecipeLabel)
        contentView.addSubview(pointerRecipeImage)
    }

    private func setupConstraints() {
        setupPhotoRecipeImageConstraints()
        setupTitleRecipeLabelConstraints()
        setupTimerRecipeImageConstraints()
        setupTimeRecipeLabelConstraints()
        setupKalRecipeImageConstraints()
        setupKalRecipeLabelConstraints()
        setupPointerRecipeImageConstraints()
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

    private func setupTimerRecipeImageConstraints() {
        NSLayoutConstraint.activate([
            timerRecipeImage.leadingAnchor.constraint(equalTo: photoRecipeImage.trailingAnchor, constant: 20),
            timerRecipeImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -23),
            timerRecipeImage.heightAnchor.constraint(equalToConstant: 15),
            timerRecipeImage.widthAnchor.constraint(equalToConstant: 15)
        ])
    }

    private func setupTimeRecipeLabelConstraints() {
        NSLayoutConstraint.activate([
            timeRecipeLabel.leadingAnchor.constraint(equalTo: timerRecipeImage.trailingAnchor, constant: 4),
            timeRecipeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -23),
            timeRecipeLabel.heightAnchor.constraint(equalToConstant: 15),
            timeRecipeLabel.widthAnchor.constraint(equalToConstant: 55)
        ])
    }

    private func setupKalRecipeImageConstraints() {
        NSLayoutConstraint.activate([
            kalRecipeImage.trailingAnchor.constraint(equalTo: kalRecipeLabel.leadingAnchor, constant: -5),
            kalRecipeImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -23),
            kalRecipeImage.heightAnchor.constraint(equalToConstant: 15),
            kalRecipeImage.widthAnchor.constraint(equalToConstant: 15)
        ])
    }

    private func setupKalRecipeLabelConstraints() {
        NSLayoutConstraint.activate([
            kalRecipeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -60),
            kalRecipeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -23),
            kalRecipeLabel.heightAnchor.constraint(equalToConstant: 15),
            kalRecipeLabel.widthAnchor.constraint(equalToConstant: 72)
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
}
