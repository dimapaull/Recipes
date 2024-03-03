// RecipeDetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер для экрана с детальным описанием рецепта
final class RecipeDetailPresenter {
    
    // MARK: - Private Properties

    private weak var view: RecipeDetailViewProtocol?
    private weak var recipeCoordinator: RecipeCoordinator?

    // MARK: - Initializers

    required init(view: RecipeDetailViewProtocol, recipeCoordinator: RecipeCoordinator) {
        self.view = view
        self.recipeCoordinator = recipeCoordinator
    }
    
    // MARK: - Private Properties
    
    private(set) var recipesDetails = RecipeDetail(
        title: "Simple Fish And Corn",
        imageName: "eat",
        dishWeight: "793",
        cookingTime: "60",
        kilocalories: "1322",
        carbohydrates: "10,78",
        fats: "10,00",
        proteins: "97,30",
        description: """
1/2 to 2 fish heads, depending on size, about 5 pounds total
2 tablespoons vegetable oil
1/4 cup red or green thai curry paste
3 tablespoons fish sauce or anchovy sauce
1 tablespoon sugar
1 can coconut milk, about 12 ounces
3 medium size asian eggplants, cut int 1 inch
rounds
Handful of bird's eye chilies
1/2 cup thai basil leaves
Juice of 3 limes
1/2 to 2 fish heads, depending on size, about 5 pounds total
2 tablespoons vegetable oil
1/4 cup red or green thai curry paste
3 tablespoons fish sauce or anchovy sauce
1 tablespoon sugar
1 can coconut milk, about 12 ounces
3 medium size asian eggplants, cut int 1 inch
rounds
Handful of bird's eye chilies
1/2 cup thai basil leaves
Juice of 3 limes
1/2 to 2 fish heads, depending on size, about 5 pounds total
2 tablespoons vegetable oil
1/4 cup red or green thai curry paste
3 tablespoons fish sauce or anchovy sauce
1 tablespoon sugar
1 can coconut milk, about 12 ounces
3 medium size asian eggplants, cut int 1 inch
rounds
Handful of bird's eye chilies
1/2 cup thai basil leaves
Juice of 3 limes
"""
    )
}
