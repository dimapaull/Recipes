// AuthorizationCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор авторизации
final class AuthorizationCoordinator: BaseCoodinator {
    // MARK: - Public Properties

    var rootController: UINavigationController?
    var onFinishFlow: (() -> ())?

    // MARK: - Public Methods

    override func start() {
        showLogin()
    }

    func onFinish() {
        onFinishFlow?()
    }

    func showLogin() {
        let authorizationView = AuthorizationView()
        let authorizationPresenter = AuthorizationPresenter(view: authorizationView)
        authorizationView.presenter = authorizationPresenter
        authorizationPresenter.authorizationCoordinator = self

        let rootController = UINavigationController(rootViewController: authorizationView)
        setAsRoot​(​_​: rootController)
        self.rootController = rootController
    }

    func showAuthorizationView() {
        let authorizationView = AuthorizationView()
        rootController?.pushViewController(authorizationView, animated: true)
    }
}
