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
        RecipeCategory(
            recipeCategoryImage: "salad",
            recipeCategoryTitle: "Salad",
            categoryName: CategoryRecipeName.salad
        ),
        RecipeCategory(recipeCategoryImage: "soup", recipeCategoryTitle: "Soup", categoryName: CategoryRecipeName.soup),
        RecipeCategory(
            recipeCategoryImage: "chicken",
            recipeCategoryTitle: "Chicken",
            categoryName: CategoryRecipeName.chicken
        ),
        RecipeCategory(recipeCategoryImage: "meat", recipeCategoryTitle: "Meat", categoryName: CategoryRecipeName.meat),
        RecipeCategory(recipeCategoryImage: "fish", recipeCategoryTitle: "Fish", categoryName: CategoryRecipeName.fish),
        RecipeCategory(
            recipeCategoryImage: "sidedish",
            recipeCategoryTitle: "Side dish",
            categoryName: CategoryRecipeName.sideDish
        ),
        RecipeCategory(
            recipeCategoryImage: "drinks",
            recipeCategoryTitle: "Drinks",
            categoryName: CategoryRecipeName.drinks
        ),
        RecipeCategory(
            recipeCategoryImage: "pancakes",
            recipeCategoryTitle: "Pancake",
            categoryName: CategoryRecipeName.pancake
        ),
        RecipeCategory(
            recipeCategoryImage: "desserts",
            recipeCategoryTitle: "Desserts",
            categoryName: CategoryRecipeName.desserts
        )
    ]

    // MARK: - Public Methods

    func textTitleSection(titleSection: String) {
        reseiver?.setTitleSection(nameSection: titleSection)
    }

    func chooseRecipe(title: CategoryRecipeName, backTitle: String) {
        recipeCoordinator?.pushCategoryView(title: title, backTitle: backTitle)
    }
}
