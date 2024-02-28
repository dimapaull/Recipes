// FavoritiesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер для экрана избранных рецептов
final class FavoritiesPresenter {
    // MARK: - Private Properties

    private weak var view: UIViewController?
    private weak var favoritiesCoordinator: FavoritiesCoordinator?

    // MARK: - Initializers

    required init(view: UIViewController, favoritiesCoordinator: FavoritiesCoordinator) {
        self.view = view
        self.favoritiesCoordinator = favoritiesCoordinator
    }
}
