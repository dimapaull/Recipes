// CategoryPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol UpdatableCell {
    var updateCell: ((DownloadState) -> ())? { get set }
    func startFetch()
}

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
    var updateCell: ((DownloadState) -> ())?

    // MARK: - Initializers

    init(view: CategoryViewProtocol, recipeCoordinator: RecipeCoordinator) {
        self.recipeCoordinator = recipeCoordinator
        self.view = view
        self.searching = false
        currentFilterState = .off
        updateCell?(.initial)
    }

    // MARK: - Public Properties
    
    private var searchingNames: [RecipeDetail] = []
    private(set) var currentRecipes: [RecipeDetail] = CategoryPresenter.recipes
    
    var searching = false

    static var recipes = [
        RecipeDetail(
            title: "Simple Fish And Corn",
            imageName: "chickenFish",
            dishWeight: "793",
            cookingTime: 60,
            kilocalories: 1322,
            carbohydrates: "10,78",
            fats: "10,00",
            proteins: "97,30",
            description: Constants.recipeDescription
        ),

        RecipeDetail(
            title: "Baked Fish with Lemon Herb Sauce",
            imageName: "bakeFish",
            dishWeight: "793",
            cookingTime: 90,
            kilocalories: 616,
            carbohydrates: "10,78",
            fats: "10,00",
            proteins: "97,30",
            description: Constants.recipeDescription
        ),

        RecipeDetail(
            title: "Lemon and Chilli Fish Burrito",
            imageName: "lemonAndChill",
            dishWeight: "793",
            cookingTime: 90,
            kilocalories: 226,
            carbohydrates: "10,78",
            fats: "10,00",
            proteins: "97,30",
            description: Constants.recipeDescription
        ),

        RecipeDetail(
            title: "Fast Roast Fish & Show Peas Recipes",
            imageName: "fastRoast",
            dishWeight: "793",
            cookingTime: 80,
            kilocalories: 94,
            carbohydrates: "10,78",
            fats: "10,00",
            proteins: "97,30",
            description: Constants.recipeDescription
        ),

        RecipeDetail(
            title: "Salmon with Cantaloupe and Fried Shallots",
            imageName: "salmon",
            dishWeight: "793",
            cookingTime: 100,
            kilocalories: 410,
            carbohydrates: "10,78",
            fats: "10,00",
            proteins: "97,30",
            description: Constants.recipeDescription
        ),

        RecipeDetail(
            title: "Chilli and Tomato Fish",
            imageName: "chillAndTomato",
            dishWeight: "793",
            cookingTime: 100,
            kilocalories: 174,
            carbohydrates: "10,78",
            fats: "10,00",
            proteins: "97,30",
            description: Constants.recipeDescription
        ),
    ]

    var currentRecipes: [RecipeDetail] = CategoryPresenter.recipes
    var currentFilterState: FilterType {
        willSet {
            currentRecipes = CategoryPresenter.recipes
            switch newValue {
            case .time:
                currentRecipes.sort { $0.cookingTime < $1.cookingTime }
            case .calories:
                currentRecipes.sort { $0.kilocalories < $1.kilocalories }
            case .twice:
                currentRecipes.sort {
                    ($0.cookingTime + $0.kilocalories) < ($1.cookingTime + $1.kilocalories)
                }
            default:
                currentRecipes = CategoryPresenter.recipes
            }
        }
    }

    // MARK: - Public Methods

    func selectionRow(in section: Int) {
        recipeCoordinator?.pushRecipeDetailView(recipe: CategoryPresenter.recipes[section])
    }
    
    func filtredRecipes(searchText: String) {
        if searchText.count < 3 {
            currentRecipes = CategoryPresenter.recipes
        } else {
            currentRecipes = CategoryPresenter.recipes.filter({
                $0.title.prefix(searchText.count) == searchText
            })
        }
        view?.reloadTable()
        recipeCoordinator?.pushRecipeDetailView(recipe: currentRecipes[section])
    }
}

// MARK: - CategoryPresenter + FilterableDelegate

extension CategoryPresenter: FilterableDelegate {
    func choosedFilter(tag: Int, complition: @escaping BoolHandler) {
        switch currentFilterState {
        case .off:
            if tag == 0 {
                currentFilterState = .calories
                complition(true)
            } else {
                currentFilterState = .time
                complition(true)
            }
        case .time:
            if tag == 1 {
                currentFilterState = .off
                complition(false)
            } else {
                currentFilterState = .twice
                complition(true)
            }
        case .calories:
            if tag == 0 {
                currentFilterState = .off
                complition(false)
            } else {
                currentFilterState = .twice
                complition(true)
            }
        case .twice:
            complition(false)
            if tag == 0 {
                currentFilterState = .time
            } else {
                currentFilterState = .calories
            }
        }
        view?.reloadTable()
    }
}

extension CategoryPresenter: UpdatableCell {
    func startFetch() {
        updateCell?(.initial)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.updateCell?(.success)
        }
    }
}
