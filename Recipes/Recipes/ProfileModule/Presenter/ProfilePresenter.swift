// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер для профиля
final class ProfilePresenter {
    // MARK: - Private Properties

    private weak var view: UIViewController?
    private weak var profileCoordinator: ProfileCoordinator?

    // MARK: - Initializers

    required init(view: UIViewController, profileCoordinator: ProfileCoordinator) {
        self.view = view
        self.profileCoordinator = profileCoordinator
    }
}
