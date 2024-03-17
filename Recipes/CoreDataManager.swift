// CoreDataManager.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import UIKit

/// Класс для работы с CoreData!
public final class CoreDataManager: NSObject {
    public static let shared = CoreDataManager()
    override private init() {}

    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
    }

    /// Вызов контейнер БД
    private var context: NSManagedObjectContext {
        appDelegate.persistentConteiner.viewContext
    }

    /// Создание объекта Photo
    public func createPhoto(_ id: Int16, url: String?) {
        guard let photoEntityDescription = NSEntityDescription.entity(forEntityName: "Photo", in: context)
        else { return }
        let photo = Photo(entity: photoEntityDescription, insertInto: context)
        photo.id = id
        photo.uri = url

        appDelegate.saveContext()
    }

    /// Получение из БД всего списка объектов типа [Photo]
    public func fetchPhotos() -> [Photo] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        do {
            return (try? context.fetch(fetchRequest) as? [Photo]) ?? []
        }
    }

    /// Получение из БД объекта типа Photo
    public func fetchPhoto(with id: Int16) -> Photo? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        do {
            let photos = try? context.fetch(fetchRequest) as? [Photo]
            return photos?.first(where: { $0.id == id })
        }
    }

    /// Сохранение объекта типа Photo в БД
    public func updatePhoto(with id: Int16, newUrl: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        do {
            guard let photos = try? context.fetch(fetchRequest) as? [Photo],
                  let photo = photos.first(where: { $0.id == id }) else { return }
            photo.uri = newUrl
        }

        appDelegate.saveContext()
    }

    /// Удаление всех объектов типа [Photo]
    public func deleteAllPhoto() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        do {
            let photos = try? context.fetch(fetchRequest) as? [Photo]
            photos?.forEach { context.delete($0) }
        }

        appDelegate.saveContext()
    }

    /// Удаление объекта типа Photo
    public func deletePhoto(with id: Int16) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        do {
            guard let photos = try? context.fetch(fetchRequest) as? [Photo],
                  let photo = photos.first(where: { $0.id == id }) else { return }
            context.delete(photo)
        }

        appDelegate.saveContext()
    }
}
