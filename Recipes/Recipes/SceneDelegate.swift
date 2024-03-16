// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private var appCoordinator: AppCoordinator?
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        configureWindow(windowScene)
    }

    private func configureWindow(_ scene: UIWindowScene) {
        window = UIWindow(windowScene: scene)
        if let window {
            window.makeKeyAndVisible()
            appCoordinator = AppCoordinator()
            appCoordinator?.start()
        }
    }
}
