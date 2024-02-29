// MainTabBarViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Таббар для всего приложения
final class MainTabBarViewController: UITabBarController {
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Private Methods

    private func configureUI() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .appLightBlue
        tabBar.unselectedItemTintColor = .appDarkGray
    }
}
