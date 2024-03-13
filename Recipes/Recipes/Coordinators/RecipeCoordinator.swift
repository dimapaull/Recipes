// RecipeCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор рецептов
final class RecipeCoordinator: BaseCoordinator {
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

    func pushCategoryView(title: CategoryRecipeName, backTitle: String) {
        let categoryView = CategoryView()
        categoryView.backNavigationTitle = backTitle
        let networkService = NetworkService()
        let categoryPresenter = CategoryPresenter(
            view: categoryView,
            recipeCoordinator: self,
            downloadRecipe: DownloadView(),
            categoryName: title,
            networkService: networkService
        )
        categoryView.presenter = categoryPresenter
        rootController?.pushViewController(categoryView, animated: true)
    }

    func pushRecipeDetailView(recipe: RecipeDetail) {
        let recipeDetailView = RecipeDetailView()
        let recipeCoordinator = RecipeCoordinator()
        let recipeDetailPresenter = RecipeDetailPresenter(
            view: recipeDetailView,
            recipeCoordinator: recipeCoordinator
        )
        recipeDetailPresenter.recipeDetailInfo = recipe
        recipeDetailView.presenter = recipeDetailPresenter
        rootController?.pushViewController(recipeDetailView, animated: true)
    }
}
