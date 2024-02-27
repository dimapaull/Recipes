// FavoritiesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер для экрана избранных рецептов
final class FavoritiesPresenter {
    // MARK: - Public Properties

    weak var favoritiesCoordinator: FavoritiesCoordinator?

    // MARK: - Private Properties

    private weak var view: UIViewController?

    // MARK: - Initializers

    required init(view: UIViewController) {
        self.view = view
    }
}
