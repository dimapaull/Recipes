// RecipePesenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер для экрана с рецептами
final class RecipePresenter {
    // MARK: - Private Properties

    private weak var view: RecipeCategoryViewProtocol?
    private weak var recipeCoordinator: RecipeCoordinator?
    private var reseiver: FileManagerServiceProtocol?

    // MARK: - Initializers

    required init(view: RecipeCategoryViewProtocol, recipeCoordinator: RecipeCoordinator) {
        self.view = view
        self.recipeCoordinator = recipeCoordinator
        reseiver = FileManagerService.fileManagerService
    }

    // MARK: - Public Properties

    private(set) var recipes = [
        RecipeCategory(recipeCategoryImage: "salad", recipeCategoryTitle: "Salad"),
        RecipeCategory(recipeCategoryImage: "soup", recipeCategoryTitle: "Soup"),
        RecipeCategory(recipeCategoryImage: "chicken", recipeCategoryTitle: "Chicken"),
        RecipeCategory(recipeCategoryImage: "meat", recipeCategoryTitle: "Meat"),
        RecipeCategory(recipeCategoryImage: "fish", recipeCategoryTitle: "Fish"),
        RecipeCategory(recipeCategoryImage: "sidedish", recipeCategoryTitle: "Side dish"),
        RecipeCategory(recipeCategoryImage: "drinks", recipeCategoryTitle: "Drinks"),
        RecipeCategory(recipeCategoryImage: "pancakes", recipeCategoryTitle: "Pancake"),
        RecipeCategory(recipeCategoryImage: "desserts", recipeCategoryTitle: "Desserts")
    ]

    // MARK: - Public Methods

    func textTitleSection(titleSection: String) {
        reseiver?.setTitleSection(nameSection: titleSection)
    }

    func chooseRecipe(title: String) {
        recipeCoordinator?.pushCategoryView(title: title)
    }
}
