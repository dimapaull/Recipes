// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер для профиля
final class ProfilePresenter {
    // MARK: - Public Properties

    weak var profileCoordinator: ProfileCoordinator?

    // MARK: - Private Properties

    private weak var view: UIViewController?

    // MARK: - Initializers

    required init(view: UIViewController) {
        self.view = view
    }
}
