// PolicyView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран политики конфиденциальности
final class PolicyView: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let dieImage = UIImage(named: "die")
        static let titleText = "Terms of Use"
        static let verdanaBold20 = UIFont(name: "Verdana-Bold", size: 20)
        static let closeButtonImage = UIImage(named: "close")
        static let verdana14 = UIFont(name: "Verdana", size: 14)
        static let policyText = """
                Welcome to our recipe app! We're thrilled to have you on board. 
        To ensure a delightful experience for everyone,
        please take a moment to familiarize yourself with our rules:
        User Accounts:
                - Maintain one account per user.
                - Safeguard your login credentials; don't share them with others.
        Content Usage:
                - Recipes and content are for personal use only.
                - Do not redistribute or republish recipes without proper attribution.
        Respect Copyright:
                - Honor the copyright of recipe authors and contributors.
                - Credit the original source when adapting or modifying a recipe.
        Community Guidelines:
                - Show respect in community features.
                - Avoid offensive language or content that violates community standards.
        Feedback and Reviews:
                - Share constructive feedback and reviews.
                - Do not submit false or misleading information.
        Data Privacy:
                - Review and understand our privacy policy regarding data collection and usage.
        Compliance with Laws:
                - Use the app in compliance with all applicable laws and regulations.
        Updates to Terms:
                - Stay informed about updates; we'll notify you of any changes.
        By using our recipe app, you agree to adhere to these rules. 
        Thank you for being a part of our culinary community!
                Enjoy exploring and cooking up a storm!
        """
    }

    // MARK: - Visual Components

    private let dieImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.dieImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel = {
        let label = UILabel()
        label.text = Constants.titleText
        label.font = Constants.verdanaBold20
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let policyLabel = {
        let label = UILabel()
        label.font = Constants.verdana14
        label.numberOfLines = 0
        label.text = Constants.policyText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var closeButton = {
        let button = UIButton()
        button.setImage(Constants.closeButtonImage, for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        view.addSubview(policyLabel)
    }

    private func setupConstraints() {
        setupDieViewImageConstraints()
        setupTitleLabelConstraints()
        setupCloseButtonConstraints()
        setupPolicyLabelConstraints()
    }

    private func setupDieViewImageConstraints() {
        dieImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 17).isActive = true
        dieImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dieImageView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        dieImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func setupTitleLabelConstraints() {
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 45).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 169).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func setupCloseButtonConstraints() {
        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 13.41).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 13.41).isActive = true
    }

    private func setupPolicyLabelConstraints() {
        policyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        policyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        policyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        policyLabel.bottomAnchor.constraint(
            equalTo:
            view.safeAreaLayoutGuide.bottomAnchor,

            constant: -80
        ).isActive = true
    }

    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
}
