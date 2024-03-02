// RecipeDetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер для экрана с детальным описанием рецепта
final class RecipeDetailPresenter {
    
    // MARK: - Private Properties

    private weak var view: UIViewController?
    private weak var recipeDetailCoordinator: RecipeDetailCoordinator?

    // MARK: - Initializers

    required init(view: UIViewController, recipeDetailCoordinator: RecipeDetailCoordinator) {
        self.view = view
        self.recipeDetailCoordinator = recipeDetailCoordinator
    }
    
    let recipesDetails: [RecipeCategory] = [
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

}
