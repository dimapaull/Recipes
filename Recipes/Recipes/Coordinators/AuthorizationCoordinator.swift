// AuthorizationCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор авторизации
final class AuthorizationCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    var rootController: UINavigationController?
    var onFinishFlow: VoidHandler?

    // MARK: - Public Methods

    func setRootViewController(view: UIViewController) {
        rootController = UINavigationController(rootViewController: view)
    }

    override func start() {
        showLogin()
    }

    func onFinish() {
        onFinishFlow?()
    }

    func showLogin() {
        let authorizationView = AuthorizationView()
        let users = UsersManager.shared
        let authorizationPresenter = AuthorizationPresenter(
            view: authorizationView,
            authorizationCoordinator: self,
            carrierState: CarrierState(usersManager: users)
        )

        authorizationView.presenter = authorizationPresenter
        let rootController = UINavigationController(rootViewController: authorizationView)
        setAsRoot​(​_​: rootController)
        self.rootController = rootController
    }

    func showAuthorizationView() {
        let authorizationView = AuthorizationView()
        rootController?.pushViewController(authorizationView, animated: true)
    }
}
