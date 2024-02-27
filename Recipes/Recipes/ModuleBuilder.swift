// ModuleBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Билдер всего приложения
final class ModuleBuilder {
    // MARK: - Constants

    private enum Constants {
        static let recipeTabBarTitle = "Recipe"
        static let favoritiesTabBarTitle = "Favorities"
        static let profileTabBarTitle = "Profile"
    }

    // MARK: - Private Methods

    func makeRecipeModule() -> RecipeView {
        let view = RecipeView()
        let recipePresenter = RecipePresenter(view: view)
        view.presenter = recipePresenter
        view.tabBarItem = UITabBarItem(title: Constants.recipeTabBarTitle, image: .recipeBar, tag: 0)
        view.tabBarItem.selectedImage = .currentRecipeBar
        return view
    }

    func makeFavoritesModule() -> FavoritiesView {
        let view = FavoritiesView()
        let favoritiesPresenter = FavoritiesPresenter(view: view)
        view.presenter = favoritiesPresenter
        view.tabBarItem = UITabBarItem(title: Constants.favoritiesTabBarTitle, image: .favoritesBar, tag: 1)
        view.tabBarItem.selectedImage = .currentFavoritesBar
        return view
    }

    func makeProfileModule() -> ProfileView {
        let view = ProfileView()
        let profilePresenter = ProfilePresenter(view: view)
        view.presenter = profilePresenter
        view.tabBarItem = UITabBarItem(title: Constants.profileTabBarTitle, image: .profileBar, tag: 1)
        view.tabBarItem.selectedImage = .currentProfileBar
        return view
    }

    func makeAuthorizationModule() -> AuthorizationView {
        let view = AuthorizationView()
        let authorizationPresenter = AuthorizationPresenter(view: view)
        view.presenter = authorizationPresenter
        return view
    }
}
