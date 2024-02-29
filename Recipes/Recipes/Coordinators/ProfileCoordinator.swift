// ProfileCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор профиля
final class ProfileCoordinator: BaseCoodinator {
    // MARK: - Public Properties

    var rootController: UINavigationController?
    var onFinishFlow: VoidHandler?

    // MARK: - Public Methods

    func setRootViewController(view: UIViewController) {
        rootController = UINavigationController(rootViewController: view)
    }

    func logOut() {
        onFinishFlow?()
    }

    func pushProfileView() {
        let pofileView = ProfileView()

        rootController?.pushViewController(pofileView, animated: true)
    }
}
