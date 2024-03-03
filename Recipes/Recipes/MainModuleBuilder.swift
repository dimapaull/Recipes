// MainModuleBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Билдер всего приложения
final class MainModuleBuilder {
    // MARK: - Constants

    private enum Constants {
        static let recipeTabBarTitle = "Recipe"
        static let favoritiesTabBarTitle = "Favorities"
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

//    func makeCategoryModule(coordinator: CategoryCoordinator) -> CategoryView {
//        let view = CategoryView()
//        let categoryPresenter = CategoryPresenter(view: view, recipeCoordinator: coordinator)
//        view.presenter = categoryPresenter
//        return view
//    }

    func makeFavoritesModule(coordinator: FavoritiesCoordinator) -> FavoritiesView {
        let view = FavoritiesView()
        let favoritiesPresenter = FavoritiesPresenter(view: view, favoritiesCoordinator: coordinator)
        view.presenter = favoritiesPresenter
        view.tabBarItem = UITabBarItem(title: Constants.favoritiesTabBarTitle, image: .favoritesBar, tag: 1)
        view.tabBarItem.selectedImage = .currentFavoritesBar
        return view
    }

    func makeProfileModule(coordinator: ProfileCoordinator) -> ProfileView {
        let view = ProfileView()
        let profilePresenter = ProfilePresenter(view: view, profileCoordinator: coordinator)
        view.presenter = profilePresenter
        view.tabBarItem = UITabBarItem(title: Constants.profileTabBarTitle, image: .profileBar, tag: 1)
        view.tabBarItem.selectedImage = .currentProfileBar
        return view
    }

    func makeAuthorizationModule(coordinator: AuthorizationCoordinator) -> AuthorizationView {
        let view = AuthorizationView()
        let authorizationPresenter = AuthorizationPresenter(view: view, authorizationCoordinator: coordinator)
        view.presenter = authorizationPresenter
        return view
    }
}
