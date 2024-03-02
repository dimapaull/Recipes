// CategoryCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор категории рецептов
final class CategoryCoordinator: BaseCoodinator {
    // MARK: - Public Properties

    var rootController: UINavigationController?
    var onFinishFlow: VoidHandler?

    // MARK: - Public Methods

    func setRootViewController(view: UIViewController) {
        rootController = UINavigationController(rootViewController: view)
    }

    func logOut() {
        onFinishFlow?()
    }

    func pushFavoritiesView() {
        let categoryView = CategoryView()
        rootController?.pushViewController(categoryView, animated: true)
    }
    
    func pushRecipeDetailView(title: String) {
        let recipeDetailView = RecipeDetailView()
        recipeDetailView.backNavigationTitle = title
        let recipeDetailCoordinator = RecipeDetailCoordinator()
        let recipeDetailPresenter = RecipeDetailPresenter(
            view: recipeDetailView,
            recipeDetailCoordinator: recipeDetailCoordinator)
        recipeDetailView.presenter = recipeDetailPresenter
        rootController?.pushViewController(recipeDetailView, animated: true)
    }
}
