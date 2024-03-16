// FavoritiesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер для экрана избранных рецептов
final class FavoritiesPresenter {
    // MARK: - Private Properties

    private weak var view: FavoritiesViewProtocol?
    private weak var favoritiesCoordinator: FavoritiesCoordinator?
    private var reseiver: FileManagerServiceProtocol?

    // MARK: - Initializers

    required init(view: FavoritiesViewProtocol, favoritiesCoordinator: FavoritiesCoordinator) {
        self.view = view
        self.favoritiesCoordinator = favoritiesCoordinator
        reseiver = FileManagerService.fileManagerService
    }

    private(set) var favouriteRecipes: [RecipeDetailTest] = FavouriteRecipes.shared.recipes

    // MARK: - Public Methods

    func favoriteViewWillAppear() {
        FavouriteRecipes.shared.getRecipes()
        favouriteRecipes = FavouriteRecipes.shared.recipes
        checkCountRecipes()
    }

    func favouriteRemoveRecipe(recipe: RecipeDetailTest?) {
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

    func textTitleSection(titleSection: String) {
        reseiver?.setTitleSection(nameSection: titleSection)
    }
}
