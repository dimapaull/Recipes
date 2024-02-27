// AuthorizationPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер для экрана авториизации
final class AuthorizationPresenter {
    // MARK: - Public Properties

    weak var authorizationCoordinator: AuthorizationCoordinator?

    // MARK: - Private Properties

    private weak var view: UIViewController?

    // MARK: - Initializers

    required init(view: UIViewController) {
        self.view = view
    }
}
