// BonusesView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран профиля пользователя
final class BonusesView: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let dieImage = UIImage(named: "die")
        static let titleText = "Your bonuses"
        static let verdanaBold20 = UIFont(name: "Verdana-Bold", size: 20)
        static let closeButtonImage = UIImage(named: "close")
        static let verdana14 = UIFont(name: "Verdana", size: 14)
        static let presentImage = UIImage(named: "present")
        static let bigStarImage = UIImage(named: "bigStar")
        static let oneHundredImage = UIImage(named: "100")
    }

    // MARK: - Visual Components

    private let dieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.dieImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.titleText
        label.textAlignment = .center
        label.font = Constants.verdanaBold20
        label.textColor = .appDarkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.closeButtonImage, for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let presentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.presentImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.bigStarImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let oneHundredImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.oneHundredImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }

    // MARK: - Private Methods

    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(dieImageView)
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.addSubview(presentImageView)
        view.addSubview(starImageView)
        view.addSubview(oneHundredImageView)
    }

    private func setupConstraints() {
        setupDieViewImageConstraints()
        setupTitleLabelConstraints()
        setupCloseButtonConstraints()
        setupPresentImageViewConstraints()
        setupStarImageViewConstraints()
        setupOneHundredImageViewConstraints()
    }

    private func setupDieViewImageConstraints() {
        dieImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 17).isActive = true
        dieImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dieImageView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        dieImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func setupTitleLabelConstraints() {
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 45).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }

    private func setupCloseButtonConstraints() {
        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 13.41).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 13.41).isActive = true
    }

    private func setupPresentImageViewConstraints() {
        presentImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 13).isActive = true
        presentImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        presentImageView.heightAnchor.constraint(equalToConstant: 136).isActive = true
        presentImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }

    private func setupStarImageViewConstraints() {
        starImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 143).isActive = true
        starImageView.topAnchor.constraint(equalTo: presentImageView.bottomAnchor, constant: 31.45).isActive = true
        starImageView.heightAnchor.constraint(equalToConstant: 27.71).isActive = true
        starImageView.widthAnchor.constraint(equalToConstant: 29.17).isActive = true
    }

    private func setupOneHundredImageViewConstraints() {
        oneHundredImageView.leadingAnchor.constraint(
            equalTo: starImageView.trailingAnchor,

            constant: 14
        ).isActive = true
        oneHundredImageView.topAnchor.constraint(
            equalTo: presentImageView.bottomAnchor,

            constant: 34
        ).isActive = true
        oneHundredImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        oneHundredImageView.heightAnchor.constraint(equalToConstant: 23).isActive = true
    }

    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
}
