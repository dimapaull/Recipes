// MainModuleBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Билдер всего приложения
final class MainModuleBuilder {
    // MARK: - Constants

    private enum Constants {
        static let recipeTabBarTitle = "Recipe"
        static let favoritesTabBarTitle = "Favorities"
        static let profileTabBarTitle = "Profile"
    }

    // MARK: - Private Methods

    func makeRecipeModule(coordinator: RecipeCoordinator) -> RecipeCategoryView {
        let view = RecipeCategoryView()
        let recipePresenter = RecipePresenter(view: view, recipeCoordinator: coordinator)
        view.presenter = recipePresenter
        view.tabBarItem = UITabBarItem(title: Constants.recipeTabBarTitle, image: .recipeBar, tag: 0)
        view.tabBarItem.selectedImage = .currentRecipeBar
        return view
    }

    func makeFavoritesModule(coordinator: FavoritesCoordinator) -> FavoritesView {
        let view = FavoritesView()
        let favoritesPresenter = FavoritesPresenter(view: view, favoritesCoordinator: coordinator)
        view.presenter = favoritesPresenter
        view.tabBarItem = UITabBarItem(title: Constants.favoritesTabBarTitle, image: .favoritesBar, tag: 1)
        view.tabBarItem.selectedImage = .currentFavoritesBar
        return view
    }

    func makeProfileModule(coordinator: ProfileCoordinator) -> ProfileView {
        let view = ProfileView()
        let users = UsersManager.shared
        let profilePresenter = ProfilePresenter(view: view, profileCoordinator: coordinator)
        view.presenter = profilePresenter
        view.carrierState = CarrierState(usersManager: users)
        view.tabBarItem = UITabBarItem(title: Constants.profileTabBarTitle, image: .profileBar, tag: 1)
        view.tabBarItem.selectedImage = .currentProfileBar
        return view
    }

    func makeAuthorizationModule(coordinator: AuthorizationCoordinator) -> AuthorizationView {
        let view = AuthorizationView()
        let users = UsersManager.shared
        let authorizationPresenter = AuthorizationPresenter(
            view: view,
            authorizationCoordinator: coordinator,
            carrierState: CarrierState(usersManager: users)
        )
        view.presenter = authorizationPresenter
        return view
    }
}
