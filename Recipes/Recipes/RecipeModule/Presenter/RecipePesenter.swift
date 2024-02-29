// RecipePesenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер для экрана с рецептами
class RecipePresenter {
    // MARK: - Private Properties

    private weak var view: UIViewController?
    private weak var recipeCoordinator: RecipeCoordinator?

    // MARK: - Initializers

    required init(view: UIViewController, recipeCoordinator: RecipeCoordinator) {
        self.view = view
        self.recipeCoordinator = recipeCoordinator
    }
}
