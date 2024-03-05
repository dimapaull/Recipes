// CategoryPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер для экрана с категорией рецепта
final class CategoryPresenter {
    // MARK: - Constants

    private enum Constants {
        static let recipeDescription = """
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
    }

    // MARK: - Private Properties

    private weak var view: CategoryViewProtocol?
    private weak var recipeCoordinator: RecipeCoordinator?

    // MARK: - Initializers

    init(view: CategoryViewProtocol, recipeCoordinator: RecipeCoordinator) {
        self.recipeCoordinator = recipeCoordinator
        self.view = view
    }

    // MARK: - Public Properties
    
    var searchingNames: [RecipeDetail] = []

    private(set) var recipes = [
        RecipeDetail(
            title: "Simple Fish And Corn",
            imageName: "chickenFish",
            dishWeight: "793",
            cookingTime: "60",
            kilocalories: "1322",
            carbohydrates: "10,78",
            fats: "10,00",
            proteins: "97,30",
            description: Constants.recipeDescription
        ),

        RecipeDetail(
            title: "Baked Fish with Lemon Herb Sauce",
            imageName: "bakeFish",
            dishWeight: "793",
            cookingTime: "90",
            kilocalories: "616",
            carbohydrates: "10,78",
            fats: "10,00",
            proteins: "97,30",
            description: Constants.recipeDescription
        ),

        RecipeDetail(
            title: "Lemon and Chilli Fish Burrito",
            imageName: "lemonAndChill",
            dishWeight: "793",
            cookingTime: "90",
            kilocalories: "226",
            carbohydrates: "10,78",
            fats: "10,00",
            proteins: "97,30",
            description: Constants.recipeDescription
        ),

        RecipeDetail(
            title: "Fast Roast Fish & Show Peas Recipes",
            imageName: "fastRoast",
            dishWeight: "793",
            cookingTime: "80",
            kilocalories: "94",
            carbohydrates: "10,78",
            fats: "10,00",
            proteins: "97,30",
            description: Constants.recipeDescription
        ),

        RecipeDetail(
            title: "Salmon with Cantaloupe and Fried Shallots",
            imageName: "salmon",
            dishWeight: "793",
            cookingTime: "100",
            kilocalories: "410",
            carbohydrates: "10,78",
            fats: "10,00",
            proteins: "97,30",
            description: Constants.recipeDescription
        ),

        RecipeDetail(
            title: "Chilli and Tomato Fish",
            imageName: "chillAndTomato",
            dishWeight: "793",
            cookingTime: "100",
            kilocalories: "174",
            carbohydrates: "10,78",
            fats: "10,00",
            proteins: "97,30",
            description: Constants.recipeDescription
        ),
    ]

    // MARK: - Public Method

    func selectionRow(in section: Int) {
        recipeCoordinator?.pushRecipeDetailView(recipe: recipes[section])
    }
    
    func filtredRecipes(searchText: String) {
        searchingNames = recipes.filter({
            $0.title.prefix(searchText.count) == searchText
        })
    }
}

// MARK: - CategoryPresenter + FilterableDelegate

extension CategoryPresenter: FilterableDelegate {
    func choosedFilter(currentState: FilterType, tag: Int, complition: @escaping (FilterType, Bool, Int?) -> ()) {
        switch currentState {
        case .off:
            if tag == 0 {
                complition(.more, true, nil)
            } else {
                complition(.less, true, nil)
            }
        case .less:
            if tag == 1 {
                complition(.off, false, nil)
            } else {
                complition(.more, true, 1)
            }
        case .more:
            if tag == 0 {
                complition(.off, false, nil)
            } else {
                complition(.less, true, 0)
            }
        }
    }
}
