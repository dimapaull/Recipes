// Photo+CoreDataProperties.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

@objc(Photo)
public class Photo: NSManagedObject {}

/// Расширение элемент Photo базы данных CoreData
extension Photo {
    @NSManaged var id: Int16
    @NSManaged var uri: String?
}
