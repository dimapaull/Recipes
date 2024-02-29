// RecipeView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с рецептами
final class RecipeView: UIViewController {
    // MARK: - Types

    // MARK: - Constants

    // MARK: - Visual Components

//    private lazy var button = {
//        let button = UIButton(frame: CGRect(x: 100, y: 200, width: 100, height: 100))
//        button.backgroundColor = .brown
//        button.addTarget(self, action: #selector(btntap), for: .touchUpInside)
//        return button
//    }()

    // MARK: - Public Properties

    var presenter: RecipePresenter?

    // MARK: - Private Properties

    // MARK: - Initializers

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
//        view.addSubview(button)
    }

    // MARK: - Public Methods

    // MARK: - Private Methods

//    @objc private func btntap() {
//        presenter?.chooseRecipe()
//    }
}
