// RecipePesenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер для экрана с рецептами
final class RecipePresenter {
    // MARK: - Private Properties

    private weak var view: UIViewController?
    private weak var recipeCoordinator: RecipeCoordinator?

    // MARK: - Initializers

    required init(view: UIViewController, recipeCoordinator: RecipeCoordinator) {
        self.view = view
        self.recipeCoordinator = recipeCoordinator
    }

    // MARK: - Public Methods

    func chooseRecipe(title: String) {
        recipeCoordinator?.pushCategoryView(title: title)
        let title = title
    }
}
