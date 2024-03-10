// FavoritiesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер для экрана избранных рецептов
final class FavoritiesPresenter {
    // MARK: - Public Properties

    var favorities: [RecipeDetail] = [
        RecipeDetail(
            title: "Salmon with Cantaloupe and Fried Shallots",
            imageName: "salmon",
            dishWeight: "793",
            cookingTime: 100,
            kilocalories: 410,
            carbohydrates: "10,78",
            fats: "10,00",
            proteins: "97,30",
            description: ""
        ),

        RecipeDetail(
            title: "Chilli and Tomato Fish",
            imageName: "chillAndTomato",
            dishWeight: "793",
            cookingTime: 100,
            kilocalories: 174,
            carbohydrates: "10,78",
            fats: "10,00",
            proteins: "97,30",
            description: ""
        ),
    ]

    // MARK: - Private Properties

    private weak var view: FavoritiesViewProtocol?
    private weak var favoritiesCoordinator: FavoritiesCoordinator?
    private var reseiver: FileManagerServiceProtocol?

    // MARK: - Initializers

    required init(view: FavoritiesViewProtocol, favoritiesCoordinator: FavoritiesCoordinator) {
        self.view = view
        self.favoritiesCoordinator = favoritiesCoordinator
        reseiver = FileManagerService.fileManagerService
    }

    // MARK: - Public Methods

    func favoriteViewWillAppear() {
        if favorities.isEmpty {
            view?.setupEmptyView()
            view?.removeTableView()
        } else {
            view?.setupTableView()
            view?.removeEmptyView()
        }
    }

    func textTitleSection(titleSection: String) {
        reseiver?.setTitleSection(nameSection: titleSection)
    }
}
