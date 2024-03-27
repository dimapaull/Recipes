// FavoritiesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер для экрана избранных рецептов
final class FavoritesPresenter {
    // MARK: - Private Properties

    private weak var view: FavoritesViewProtocol?
    private weak var favoritesCoordinator: FavoritesCoordinator?
    private var reseiver: FileManagerServiceProtocol?

    // MARK: - Initializers

    required init(view: FavoritesViewProtocol, favoritesCoordinator: FavoritesCoordinator) {
        self.view = view
        self.favoritesCoordinator = favoritesCoordinator
        reseiver = FileManagerService.fileManagerService
    }

    private(set) var favouriteRecipes: [Recipe] = FavouriteRecipes.shared.recipes

    // MARK: - Public Methods

    func favoriteViewWillAppear() {
//        FavouriteRecipes.shared.getRecipes()
        favouriteRecipes = FavouriteRecipes.shared.recipes
        checkCountRecipes()
    }

    func favouriteRemoveRecipe(recipe: Recipe?) {
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
