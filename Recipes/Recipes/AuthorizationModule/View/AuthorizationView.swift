// AuthorizationView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран авторизации пользователя
final class AuthorizationView: UIViewController {
    // MARK: - Types

    // MARK: - Constants

    private enum Constants {
        static let loginText = "Login"
    }

    // MARK: - Visual Components

    private let loginButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.setTitle(Constants.loginText, for: .normal)
        button.titleLabel?.font = UIFont.verdana(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .appDarkGreen
        return button
    }()

    // MARK: - Public Properties

    var presenter: AuthorizationPresenter?

    // MARK: - Private Properties

    // MARK: - Initializers

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configurenavigationBar()
        configureUI()
    }

    // MARK: - Public Methods

    // MARK: - Private Methods

    private func configurenavigationBar() {
        title = Constants.loginText
        navigationController?.navigationBar.prefersLargeTitles = true
        let dd = NSMutableAttributedString(
            string: Constants.loginText,
            attributes: [NSAttributedString.Key.font: UIFont.verdanaBold(ofSize: 27)]
        )
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
    }

    private func configureUI() {
        view.backgroundColor = .white
        addSubviews()
        addLoginButtonAnchors()
    }

    private func addSubviews() {
        for item in [loginButton] {
            item.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(item)
        }
    }

    private func addLoginButtonAnchors() {
        loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -43)
            .isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
}
