// RecipeDTO.swift
// Copyright © RoadMap. All rights reserved.

/// Объект передачи данных рецепта детального
struct RecipeDTO: Codable {
    let uri: String
    let label: String
    let image: String
    let calories: Double
    let totalTime: Double
    let totalWeight: Double

    let totalNutrients: TotalNutrientsDTO
    let ingredientLines: [String]
}
