// RecipePesenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер для экрана с рецептами
class RecipePresenter {
    // MARK: - Public Properties

    weak var recipeCoordinator: RecipeCoordinator?

    // MARK: - Private Properties

    private weak var view: UIViewController?

    // MARK: - Initializers

    required init(view: UIViewController) {
        self.view = view
    }
}
