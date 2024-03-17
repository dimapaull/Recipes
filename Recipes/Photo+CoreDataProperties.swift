//
//  Photo+CoreDataProperties.swift
//  
//
//  Created by Dmitriy Starozhilov on 18.03.2024.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var id: Int16
    @NSManaged public var url: String?

}
