// RecipeDetailCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор подробного описания рецепта
final class RecipeDetailCoordinator: BaseCoodinator {
    
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
    
    func pushRecipeDetailView() {
        let recipeDetailView = RecipeDetailView()
        rootController?.pushViewController(recipeDetailView, animated: true)
    }
}
