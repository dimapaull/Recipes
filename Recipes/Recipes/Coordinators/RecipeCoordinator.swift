// RecipeCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор рецептов
final class RecipeCoordinator: BaseCoodinator {
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

    func pushCategoryView(title: String) {
        let categoryView = CategoryView()
        categoryView.backNavigationTitle = title
        let categoryPresenter = CategoryPresenter(view: categoryView, recipeCoordinator: self)
        categoryView.presenter = categoryPresenter
        rootController?.pushViewController(categoryView, animated: true)
    }
    
    func pushRecipeDetailView(title: String) {
        let recipeDetailView = RecipeDetailView()
        recipeDetailView.backNavigationTitle = title
        let recipeCoordinator = RecipeCoordinator()
        let recipeDetailPresenter = RecipeDetailPresenter(
            view: recipeDetailView,
            recipeCoordinator: recipeCoordinator)
        recipeDetailView.presenter = recipeDetailPresenter
        rootController?.pushViewController(recipeDetailView, animated: true)
    }
}
