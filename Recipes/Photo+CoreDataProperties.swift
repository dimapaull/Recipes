// Photo+CoreDataProperties.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

///
public extension Photo {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Photo> {
        NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged var url: String?
    @NSManaged var id: Int16
}
