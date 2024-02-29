// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Главный координатор
final class AppCoordinator: BaseCoodinator {
    // MARK: - Constants

    private enum Constants {
        static let adminLoginText = "admin"
        static let adminValidateText = "user"
    }

    // MARK: - Private Properties

    private var mainBarViewController: MainTabBarViewController?
    private var appBuilder = MainModuleBuilder()

    // MARK: - Private Methods

    override func start() {
//        if Constants.adminLoginText == Constants.adminValidateText {
//            goToMain()
//        } else {
//            goT​oAuth​()
//        }
        goToMain()
    }

    private func goToMain() {
        mainBarViewController = MainTabBarViewController()
        /// Установка экрана с рецептами
        let recipeCoordinator = RecipeCoordinator()
        let recipeModuleView = appBuilder.makeRecipeModule(coordinator: recipeCoordinator)
        recipeCoordinator.setRootViewController(view: recipeModuleView)
        add(coordinator: recipeCoordinator)

        /// Установка экрана с избранными  рецептами
        let favoritiesCoordinator = FavoritiesCoordinator()
        let favoritiesView = appBuilder.makeFavoritesModule(coordinator: favoritiesCoordinator)
        favoritiesCoordinator.setRootViewController(view: favoritiesView)
        add(coordinator: favoritiesCoordinator)

        guard let favoritiesView = favoritiesCoordinator.rootController else { return }

        /// Устновка экрана профиля пользователя
        let profileCoordinator = ProfileCoordinator()
        let profileView = appBuilder.makeProfileModule(coordinator: profileCoordinator)
        profileCoordinator.setRootViewController(view: profileView)

        add(coordinator: profileCoordinator)
        guard let profileView = profileCoordinator.rootController else { return }

        profileCoordinator.onFinishFlow = { [weak self] in
            self?.remove(coordinator: recipeCoordinator)
            self?.remove(coordinator: profileCoordinator)
            self?.mainBarViewController = nil
            self?.goT​oAuth​()
        }

        mainBarViewController?.setViewControllers(
            [recipeModuleView, favoritiesView, profileView],
            animated: true
        )
        setAsRoot​(​_​: mainBarViewController ?? UITabBarController())
    }

    private func goT​oAuth​() {
        let authorizationCoordinator = AuthorizationCoordinator()
        authorizationCoordinator.onFinishFlow = { [weak self] in
            self?.remove(coordinator: authorizationCoordinator)
            self?.goToMain()
        }
        add(coordinator: authorizationCoordinator)
        authorizationCoordinator.start()
    }
}
