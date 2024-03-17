// FavoritesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор избранных рецептов
final class FavoritesCoordinator: BaseCoordinator {
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

    func pushFavoritesView() {
        let favoritesView = FavoritesView()
        let favoritesPresenter = FavoritesPresenter(view: favoritesView, favoritesCoordinator: self)
        favoritesView.presenter = favoritesPresenter
        rootController?.pushViewController(favoritesView, animated: true)
    }
}
