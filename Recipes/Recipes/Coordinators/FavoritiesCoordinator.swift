// FavoritiesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор избранных рецептов
final class FavoritiesCoordinator: BaseCoodinator {
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
        let favoritiesView = FavoritiesView()
        let favoritiesPresenter = FavoritiesPresenter(view: favoritiesView, favoritiesCoordinator: self)
        favoritiesView.presenter = favoritiesPresenter
        rootController?.pushViewController(favoritiesView, animated: true)
    }
}
