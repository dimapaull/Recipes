// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Главный координатор
final class AppCoordinator: BaseCoordinator {
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
        if Constants.adminLoginText == Constants.adminLoginText {
            goToMain()
        } else {
            goT​oAuth​()
        }
    }

    private func goToMain() {
        mainBarViewController = MainTabBarViewController()
        /// Установка экрана с рецептами
        let recipeCoordinator = RecipeCoordinator()
        let recipeView = appBuilder.makeRecipeModule(coordinator: recipeCoordinator)
        recipeCoordinator.setRootViewController(view: recipeView)
        add(coordinator: recipeCoordinator)

        guard let recipeModule = recipeCoordinator.rootController else { return }

        /// Установка экрана с избранными  рецептами
        let favoritiesCoordinator = FavoritesCoordinator()
        let favoritiesView = appBuilder.makeFavoritesModule(coordinator: favoritiesCoordinator)
        favoritiesCoordinator.setRootViewController(view: favoritiesView)
        add(coordinator: favoritiesCoordinator)

        guard let favoritiesModule = favoritiesCoordinator.rootController else { return }

        /// Устновка экрана профиля пользователя
        let profileCoordinator = ProfileCoordinator()
        let profileView = appBuilder.makeProfileModule(coordinator: profileCoordinator)
        profileCoordinator.setRootViewController(view: profileView)

        guard let profileModule = profileCoordinator.rootController else { return }

        add(coordinator: profileCoordinator)

        profileCoordinator.onFinishFlow = { [weak self] in
            self?.remove(coordinator: recipeCoordinator)
            self?.remove(coordinator: profileCoordinator)
            self?.mainBarViewController = nil
            self?.goT​oAuth​()
        }

        mainBarViewController?.setViewControllers(
            [recipeModule, favoritiesModule, profileModule],
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
