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

    private var tabBarViewController: MainTabBarViewController?
    private var appBuilder = ModuleBuilder()

    // MARK: - Private Methods

    override func start() {
        if Constants.adminLoginText == Constants.adminValidateText {
            goToMain()
        } else {
            goT​oAuth​()
        }
        goToMain()
    }

    private func goToMain() {
        tabBarViewController = MainTabBarViewController()
        /// Установка экрана с рецептами
        let recipeModuleView = appBuilder.makeRecipeModule()
        let recipeCoordinator = RecipeCoordinator(rootController: recipeModuleView)
        recipeModuleView.presenter?.recipeCoordinator = recipeCoordinator
        add(coordinator: recipeCoordinator)

        /// Установка экрана с избранными  рецептами
        let favoritiesView = appBuilder.makeFavoritesModule()
        let favoritiesCoordinator = FavoritiesCoordinator(rootController: favoritiesView)
        favoritiesView.presenter?.favoritiesCoordinator = favoritiesCoordinator
        add(coordinator: favoritiesCoordinator)

        /// Устновка экрана профиля пользователя
        let profileView = appBuilder.makeProfileModule()
        let profileCoordinator = ProfileCoordinator(rootController: profileView)
        profileView.presenter?.profileCoordinator = profileCoordinator
        add(coordinator: profileCoordinator)

        profileCoordinator.onFinishFlow = { [weak self] in
            self?.remove(coordinator: recipeCoordinator)
            self?.remove(coordinator: profileCoordinator)
            self?.tabBarViewController = nil
            self?.goT​oAuth​()
        }

        tabBarViewController?.setViewControllers(
            [recipeCoordinator.rootController, favoritiesCoordinator.rootController, profileCoordinator.rootController],
            animated: true
        )
        setAsRoot​(​_​: tabBarViewController ?? UITabBarController())
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
