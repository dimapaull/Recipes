// AppDelegate.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        true
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options _: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    /// Создание контейнера (CoreData), который хранит все данные
    lazy var persistentConteiner: NSPersistentContainer = {
        let conteiner = NSPersistentContainer(name: "CoreData")
        conteiner.loadPersistentStores { description, error in
            if let error {
                print(error.localizedDescription)
            } else {
                print("DB url -", description.url?.absoluteString ?? "Not found url")
            }
        }
        return conteiner
    }()

    /// Создание слепка - копия контейнера (CoreData) для совершения быстрых действий с БД
    func saveContext() {
        let context = persistentConteiner.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}
