// RecipeDetailCompoundCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с составом рецепта
final class RecipeDetailCompoundCell: UITableViewCell {
    static let identifier = "RecipeDetailCompoundCell"

    // MARK: - Constants

    private enum Constants {
        static let verdanaSize10 = UIFont(name: "Verdana", size: 10)
        static let kCal = " kcal"
        static let potChar = " g"
        static let backgroundImage = UIImage(named: "backgroundImageCell")
        static let topBackgroundImage = UIImage(named: "topBackgroundImageCell")
        static let enercKcalTitle = "Enerc kcal"
        static let carbohydratesTitle = "Carbohydrates"
        static let fatsTitle = "Fats"
        static let proteinsTitle = "Proteins"
    }

    // MARK: - Visual Components

    private let enercKcalImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.backgroundImage
        return imageView
    }()

    private let enercKcalTopImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.topBackgroundImage
        return imageView
    }()

    private let enercKcalTitleLabel = {
        let label = UILabel()
        label.font = Constants.verdanaSize10
        label.textAlignment = .center
        label.textColor = .white
        label.text = Constants.enercKcalTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let enercKcalLabel = {
        let label = UILabel()
        label.font = Constants.verdanaSize10
        label.textAlignment = .center
        label.textColor = .appLightBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let carbohydratesImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.backgroundImage
        return imageView
    }()

    private let carbohydratesTopImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.topBackgroundImage
        return imageView
    }()

    private let carbohydratesTitleLabel = {
        let label = UILabel()
        label.font = Constants.verdanaSize10
        label.textAlignment = .center
        label.textColor = .white
        label.text = Constants.carbohydratesTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let carbohydratesLabel = {
        let label = UILabel()
        label.font = Constants.verdanaSize10
        label.textAlignment = .center
        label.textColor = .appLightBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let fatsImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.backgroundImage
        return imageView
    }()

    private let fatsTopImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.topBackgroundImage
        return imageView
    }()

    private let fatsTitleLabel = {
        let label = UILabel()
        label.font = Constants.verdanaSize10
        label.textAlignment = .center
        label.textColor = .white
        label.text = Constants.fatsTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let fatsLabel = {
        let label = UILabel()
        label.font = Constants.verdanaSize10
        label.textAlignment = .center
        label.textColor = .appLightBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let proteinsImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.backgroundImage
        return imageView
    }()

    private let proteinsTopImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.topBackgroundImage
        return imageView
    }()

    private let proteinsTitleLabel = {
        let label = UILabel()
        label.font = Constants.verdanaSize10
        label.textAlignment = .center
        label.textColor = .white
        label.text = Constants.proteinsTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let proteinsLabel = {
        let label = UILabel()
        label.font = Constants.verdanaSize10
        label.textAlignment = .center
        label.textColor = .appLightBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

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

    // MARK: - Public Methods

    func configureCell(info: RecipeDetailTest?) {
        enercKcalLabel.text = "\(Int(info?.calories ?? 0)) \(Constants.kCal)"
        carbohydratesLabel.text = String(Int(info?.totalNutrients.carb?.quantity ?? 0)) + Constants.potChar
        fatsLabel.text = String(Int(info?.totalNutrients.fat?.quantity ?? 0)) + Constants.potChar
        proteinsLabel.text = String(Int(info?.totalNutrients.protein?.quantity ?? 0)) + Constants.potChar
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
        enercKcalImageView.addSubview(enercKcalTopImageView)
        enercKcalTopImageView.addSubview(enercKcalTitleLabel)
        enercKcalImageView.addSubview(enercKcalLabel)
        carbohydratesImageView.addSubview(carbohydratesTopImageView)
        carbohydratesTopImageView.addSubview(carbohydratesTitleLabel)
        carbohydratesImageView.addSubview(carbohydratesLabel)
        fatsImageView.addSubview(fatsTopImageView)
        fatsTopImageView.addSubview(fatsTitleLabel)
        fatsImageView.addSubview(fatsLabel)
        proteinsImageView.addSubview(proteinsTopImageView)
        proteinsTopImageView.addSubview(proteinsTitleLabel)
        proteinsImageView.addSubview(proteinsLabel)
        contentView.addSubview(elementsStackView)
    }

    private func setupConstraints() {
        setupElementsStackViewConstraints()
        setupEnercKcalTopImageViewConstraints()
        setupEnercKcalTitleLabelConstraints()
        setupEnercKcalLabelConstraints()
        setupCarbohydratesTopImageViewConstraints()
        setupCarbohydratesTitleLabelConstraints()
        setupCarbohydratesLabelConstraints()
        setupFatsTopImageViewConstraints()
        setupFatsTitleLabelConstraints()
        setupFatsLabelConstraints()
        setupProteinsTopImageViewConstraints()
        setupProteinsTitleLabelConstraints()
        setupProteinsLabelConstraints()
    }

    private func setupElementsStackViewConstraints() {
        NSLayoutConstraint.activate([
            elementsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            elementsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            elementsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            elementsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    private func setupEnercKcalTopImageViewConstraints() {
        NSLayoutConstraint.activate([
            enercKcalTopImageView.leadingAnchor.constraint(equalTo: enercKcalImageView.leadingAnchor),
            enercKcalTopImageView.topAnchor.constraint(equalTo: enercKcalImageView.topAnchor),
            enercKcalTopImageView.trailingAnchor.constraint(equalTo: enercKcalImageView.trailingAnchor),
            enercKcalTopImageView.heightAnchor.constraint(equalToConstant: 31),
            enercKcalTopImageView.widthAnchor.constraint(equalToConstant: 73)
        ])
    }

    private func setupEnercKcalTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            enercKcalTitleLabel.centerXAnchor.constraint(equalTo: enercKcalTopImageView.centerXAnchor),
            enercKcalTitleLabel.centerYAnchor.constraint(equalTo: enercKcalTopImageView.centerYAnchor),
            enercKcalTitleLabel.heightAnchor.constraint(equalToConstant: 14),
            enercKcalTitleLabel.widthAnchor.constraint(equalToConstant: 74)
        ])
    }

    private func setupEnercKcalLabelConstraints() {
        NSLayoutConstraint.activate([
            enercKcalLabel.centerXAnchor.constraint(equalTo: enercKcalImageView.centerXAnchor),
            enercKcalLabel.bottomAnchor.constraint(equalTo: enercKcalImageView.bottomAnchor, constant: -4),
            enercKcalLabel.heightAnchor.constraint(equalToConstant: 15),
            enercKcalLabel.widthAnchor.constraint(equalToConstant: 64)
        ])
    }

    private func setupCarbohydratesTopImageViewConstraints() {
        NSLayoutConstraint.activate([
            carbohydratesTopImageView.leadingAnchor.constraint(equalTo: carbohydratesImageView.leadingAnchor),
            carbohydratesTopImageView.topAnchor.constraint(equalTo: carbohydratesImageView.topAnchor),
            carbohydratesTopImageView.trailingAnchor.constraint(equalTo: carbohydratesImageView.trailingAnchor),
            carbohydratesTopImageView.heightAnchor.constraint(equalToConstant: 31),
            carbohydratesTopImageView.widthAnchor.constraint(equalToConstant: 73)
        ])
    }

    private func setupCarbohydratesTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            carbohydratesTitleLabel.centerXAnchor.constraint(equalTo: carbohydratesTopImageView.centerXAnchor),
            carbohydratesTitleLabel.centerYAnchor.constraint(equalTo: carbohydratesTopImageView.centerYAnchor),
            carbohydratesTitleLabel.heightAnchor.constraint(equalToConstant: 14),
            carbohydratesTitleLabel.widthAnchor.constraint(equalToConstant: 74)
        ])
    }

    private func setupCarbohydratesLabelConstraints() {
        NSLayoutConstraint.activate([
            carbohydratesLabel.centerXAnchor.constraint(equalTo: carbohydratesImageView.centerXAnchor),
            carbohydratesLabel.bottomAnchor.constraint(equalTo: carbohydratesImageView.bottomAnchor, constant: -4),
            carbohydratesLabel.heightAnchor.constraint(equalToConstant: 15),
            carbohydratesLabel.widthAnchor.constraint(equalToConstant: 64)
        ])
    }

    private func setupFatsTopImageViewConstraints() {
        NSLayoutConstraint.activate([
            fatsTopImageView.leadingAnchor.constraint(equalTo: fatsImageView.leadingAnchor),
            fatsTopImageView.topAnchor.constraint(equalTo: fatsImageView.topAnchor),
            fatsTopImageView.trailingAnchor.constraint(equalTo: fatsImageView.trailingAnchor),
            fatsTopImageView.heightAnchor.constraint(equalToConstant: 31),
            fatsTopImageView.widthAnchor.constraint(equalToConstant: 73)
        ])
    }

    private func setupFatsTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            fatsTitleLabel.centerXAnchor.constraint(equalTo: fatsTopImageView.centerXAnchor),
            fatsTitleLabel.centerYAnchor.constraint(equalTo: fatsTopImageView.centerYAnchor),
            fatsTitleLabel.heightAnchor.constraint(equalToConstant: 14),
            fatsTitleLabel.widthAnchor.constraint(equalToConstant: 74)
        ])
    }

    private func setupFatsLabelConstraints() {
        NSLayoutConstraint.activate([
            fatsLabel.centerXAnchor.constraint(equalTo: fatsImageView.centerXAnchor),
            fatsLabel.bottomAnchor.constraint(equalTo: fatsImageView.bottomAnchor, constant: -4),
            fatsLabel.heightAnchor.constraint(equalToConstant: 15),
            fatsLabel.widthAnchor.constraint(equalToConstant: 64)
        ])
    }

    private func setupProteinsTopImageViewConstraints() {
        NSLayoutConstraint.activate([
            proteinsTopImageView.leadingAnchor.constraint(equalTo: proteinsImageView.leadingAnchor),
            proteinsTopImageView.topAnchor.constraint(equalTo: proteinsImageView.topAnchor),
            proteinsTopImageView.trailingAnchor.constraint(equalTo: proteinsImageView.trailingAnchor),
            proteinsTopImageView.heightAnchor.constraint(equalToConstant: 31),
            proteinsTopImageView.widthAnchor.constraint(equalToConstant: 73)
        ])
    }

    private func setupProteinsTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            proteinsTitleLabel.centerXAnchor.constraint(equalTo: proteinsTopImageView.centerXAnchor),
            proteinsTitleLabel.centerYAnchor.constraint(equalTo: proteinsTopImageView.centerYAnchor),
            proteinsTitleLabel.heightAnchor.constraint(equalToConstant: 14),
            proteinsTitleLabel.widthAnchor.constraint(equalToConstant: 74)
        ])
    }

    private func setupProteinsLabelConstraints() {
        NSLayoutConstraint.activate([
            proteinsLabel.centerXAnchor.constraint(equalTo: proteinsImageView.centerXAnchor),
            proteinsLabel.bottomAnchor.constraint(equalTo: proteinsImageView.bottomAnchor, constant: -4),
            proteinsLabel.heightAnchor.constraint(equalToConstant: 15),
            proteinsLabel.widthAnchor.constraint(equalToConstant: 64)
        ])
    }
}
