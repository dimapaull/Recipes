// FavoritiesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер для экрана избранных рецептов
final class FavoritiesPresenter {
    // MARK: - Public Properties

//    var favorities: [RecipeDetail] = [
//        RecipeDetail(
//            title: "Salmon with Cantaloupe and Fried Shallots",
//            imageName: "salmon",
//            dishWeight: "793",
//            cookingTime: 100,
//            kilocalories: 410,
//            carbohydrates: "10,78",
//            fats: "10,00",
//            proteins: "97,30",
//            description: ""
//        ),
//
//        RecipeDetail(
//            title: "Chilli and Tomato Fish",
//            imageName: "chillAndTomato",
//            dishWeight: "793",
//            cookingTime: 100,
//            kilocalories: 174,
//            carbohydrates: "10,78",
//            fats: "10,00",
//            proteins: "97,30",
//            description: ""
//        ),
//    ]

    // MARK: - Private Properties

    private weak var view: FavoritiesViewProtocol?
    private weak var favoritiesCoordinator: FavoritiesCoordinator?

    // MARK: - Initializers

    required init(view: FavoritiesViewProtocol, favoritiesCoordinator: FavoritiesCoordinator) {
        self.view = view
        self.favoritiesCoordinator = favoritiesCoordinator
        FavouriteRecipes.shared.getRecipes()
    }

    private(set) var favouriteRecipes: [RecipeDetail] = FavouriteRecipes.shared.recipes

    // MARK: - Public Methods

    func favoriteViewWillAppear() {
        FavouriteRecipes.shared.getRecipes()
        favouriteRecipes = FavouriteRecipes.shared.recipes
        checkCountRecipes()
    }

    func favouriteRemoveRecipe(recipe: RecipeDetail?) {
        guard let recipe = recipe else { return }
        FavouriteRecipes.shared.updateFavouriteRecipe(recipe)
        favouriteRecipes = FavouriteRecipes.shared.recipes
        checkCountRecipes()
    }

    func checkCountRecipes() {
        if favouriteRecipes.isEmpty {
            view?.setupEmptyView()
            view?.removeTableView()
        } else {
            view?.setupTableView()
            view?.removeEmptyView()
        }
    }
}
