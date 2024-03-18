// RecipeCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор рецептов
final class RecipeCoordinator: BaseCoordinator {
    private let networkService = NetworkService()
    private let coreDataService = StorageService()

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

        let categoryPresenter = CategoryPresenter(
            view: categoryView,
            recipeCoordinator: self,
            downloadRecipe: DownloadRecipe(),
            categoryName: title,
            networkService: networkService,
            coreDataService: coreDataService
        )
        categoryView.presenter = categoryPresenter
        rootController?.pushViewController(categoryView, animated: true)
    }

    func pushRecipeDetailView(uri: String) {
        let recipeDetailView = RecipeDetailView()
        let recipeCoordinator = RecipeCoordinator()
        let recipeDetailPresenter = RecipeDetailPresenter(
            view: recipeDetailView,
            recipeCoordinator: recipeCoordinator,
            downloadRecipe: DownloadRecipe(),
            networkService: networkService,
            coreDataService: coreDataService
        )
        recipeDetailPresenter.detailURI = uri
        recipeDetailView.presenter = recipeDetailPresenter
        rootController?.pushViewController(recipeDetailView, animated: true)
    }
}
