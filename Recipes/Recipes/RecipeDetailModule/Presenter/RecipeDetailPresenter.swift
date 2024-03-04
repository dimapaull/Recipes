// RecipeDetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер для экрана с детальным описанием рецепта
final class RecipeDetailPresenter {
    // MARK: - Private Properties

    private weak var view: RecipeDetailViewProtocol?
    private weak var recipeCoordinator: RecipeCoordinator?

    // MARK: - Public Properties

    var recipeDetailInfo: RecipeDetail?

    // MARK: - Initializers

    required init(view: RecipeDetailViewProtocol, recipeCoordinator: RecipeCoordinator) {
        self.view = view
        self.recipeCoordinator = recipeCoordinator
    }
}
