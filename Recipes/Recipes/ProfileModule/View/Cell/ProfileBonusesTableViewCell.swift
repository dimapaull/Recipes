// ProfileBonusesTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с переходом на окно "Бонусы"
final class ProfileBonusesTableViewCell: UITableViewCell {
    
    // MARK: - Constants

    enum Constants {
        static let identifier = "ProfileBonusesTableViewCell"
        static let lightGrayImage = UIImage(named: "lightGrayView")
        static let starImage = UIImage(named: "star")
        static let bonusesText = "Bonuses"
        static let verdanaSize18 = UIFont(name: "Verdana", size: 18)
        static let pointerImage = UIImage(named: "pointer")
    }

    // MARK: - Private Properties

    private let lightGrayImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = Constants.lightGrayImage
        return view
    }()

    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.starImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let bonusesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.bonusesText
        label.textColor = .appDarkGray
        label.font = Constants.verdanaSize18
        return label
    }()

    private let pointerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.pointerImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .appLightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setupConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupView()
        setupConstraints()
    }

    // MARK: - Private Methods

    private func setupView() {
        contentView.addSubview(lightGrayImageView)
        contentView.addSubview(starImageView)
        contentView.addSubview(bonusesLabel)
        contentView.addSubview(pointerImageView)
        contentView.addSubview(lineView)
    }

    private func setupConstraints() {
        setuplightGrayImageViewConstraints()
        setupStarImageViewConstraints()
        setupBonusesLabelConstraints()
        setupPointerImageViewConstraints()
        setupLineViewConstraints()
    }

    private func setuplightGrayImageViewConstraints() {
        lightGrayImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        lightGrayImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        lightGrayImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        lightGrayImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
    }

    private func setupStarImageViewConstraints() {
        starImageView.centerXAnchor.constraint(equalTo: lightGrayImageView.centerXAnchor).isActive = true
        starImageView.centerYAnchor.constraint(equalTo: lightGrayImageView.centerYAnchor).isActive = true
        starImageView.heightAnchor.constraint(equalToConstant: 22.17).isActive = true
        starImageView.widthAnchor.constraint(equalToConstant: 23.34).isActive = true
    }

    private func setupBonusesLabelConstraints() {
        bonusesLabel.leadingAnchor.constraint(equalTo: lightGrayImageView.trailingAnchor, constant: 16).isActive = true
        bonusesLabel.centerYAnchor.constraint(equalTo: lightGrayImageView.centerYAnchor).isActive = true
        bonusesLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        bonusesLabel.widthAnchor.constraint(equalToConstant: 224).isActive = true
    }

    private func setupPointerImageViewConstraints() {
        pointerImageView.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor).isActive = true
        pointerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -33.5).isActive = true
        pointerImageView.heightAnchor.constraint(equalToConstant: 14).isActive = true
        pointerImageView.widthAnchor.constraint(equalToConstant: 7).isActive = true
    }

    private func setupLineViewConstraints() {
        lineView.leadingAnchor.constraint(equalTo: lightGrayImageView.trailingAnchor, constant: 16).isActive = true
        lineView.topAnchor.constraint(equalTo: bonusesLabel.bottomAnchor, constant: 16).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: 249).isActive = true
    }
}
