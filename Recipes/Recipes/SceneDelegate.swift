// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        configueWindow(windowScene)
    }

    private func configueWindow(_ scene: UIWindowScene) {
        window = UIWindow(windowScene: scene)
        window?.windowScene = scene
        window?.makeKeyAndVisible()
        window?.rootViewController = ViewController()
    }
}
