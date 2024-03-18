// RecipeData+CoreDataProperties.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

/// Расширение модели рецепта с описанием для хранения
public extension RecipeData {
    @nonobjc class func fetchRequest() -> NSFetchRequest<RecipeData> {
        NSFetchRequest<RecipeData>(entityName: "RecipeData")
    }

    @NSManaged var category: String
    @NSManaged var uri: String
    @NSManaged var label: String
    @NSManaged var image: String
    @NSManaged var calories: Double
    @NSManaged var totalTime: Double
    @NSManaged var totalWeight: Double
    @NSManaged var energyCalories: Double
    @NSManaged var carb: Double
    @NSManaged var fat: Double
    @NSManaged var protein: Double
    @NSManaged var ingredientLines: String
}
