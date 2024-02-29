// CategoryPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер для экрана с категорией рецепта
final class CategoryPresenter {
    // MARK: - Private Properties

    private weak var view: CategoryViewProtocol?
    private weak var categoryCoordinator: CategoryCoordinator?

    // MARK: - Initializers

    init(view: CategoryViewProtocol, categoryCoordinator: CategoryCoordinator) {
        self.categoryCoordinator = categoryCoordinator
        self.view = view
    }

    // MARK: - Life Cycle

    // MARK: - Public Methods

    // MARK: - Private Methods
}
