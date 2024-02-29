// CategoryPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер для экрана с категорией рецепта
final class CategoryPresenter {
    // MARK: - Private Properties

    private weak var view: CategoryViewProtocol?
    private weak var categoryCoordinator: CategoryCoordinator?

    // MARK: - Initializers

    init(view: CategoryViewProtocol, categoryCoordinator: CategoryCoordinator) {
        self.categoryCoordinator = categoryCoordinator
        self.view = view
    }

    // MARK: - Public Properties

    private(set) var recipes = [
        Category(name: "Simple Fish And Corn", imageName: "chicken", minuteTime: 60, foodSuply: 274),
        Category(name: "Baked Fish with Lemon Herb Sauce", imageName: "bakeFish", minuteTime: 90, foodSuply: 616),
        Category(name: "Lemon and Chilli Fish Burrito", imageName: "lemonAndChill", minuteTime: 90, foodSuply: 226),
        Category(name: "Fast Roast Fish & Show Peas Recipes", imageName: "fastRoast", minuteTime: 80, foodSuply: 94),
        Category(
            name: "Salmon with Cantaloupe and Fried Shallots",
            imageName: "salmon",
            minuteTime: 100,
            foodSuply: 410
        ),
        Category(name: "Chilli and Tomato Fish", imageName: "chillAndTomato", minuteTime: 100, foodSuply: 174)
    ]
}