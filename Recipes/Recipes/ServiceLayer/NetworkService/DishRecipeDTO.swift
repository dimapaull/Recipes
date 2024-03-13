// DishRecipeDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Объект передачи данных списка рецептов
struct RecipeListDTO: Decodable {
    let hits: [DishRecipeDTO]
}

/// Объект передачи данных рецепта
struct DishRecipeDTO: Decodable {
    let recipe: RecipeDTO
}

/// Объект передачи данных рецепта детального
struct RecipeDTO: Decodable {
    let uri: String
    let label: String
    let image: String
    let calories: Double
    let totalTime: Double
    let totalWeight: Double

    let totalNutrients: TotalNutrients
    let ingredientLines: [String]
}

/// Объект передачи описания рецепта
struct TotalNutrients: Decodable {
    let energyCalories: MeasuredCalories?
    let carb: MeasuredGrams?
    let fat: MeasuredGrams?
    let protein: MeasuredGrams?

    enum CodingKeys: String, CodingKey {
        case energyCalories = "ENERC_KCAL"
        case carbGram = "CHOCDF"
        case fatGram = "FAT"
        case protein = "PROCNT"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        energyCalories = try? container.decode(MeasuredCalories.self, forKey: .energyCalories)
        carb = try? container.decode(MeasuredGrams.self, forKey: .carbGram)
        fat = try? container.decode(MeasuredGrams.self, forKey: .fatGram)
        protein = try? container.decode(MeasuredGrams.self, forKey: .protein)
    }
}

/// Объект передачи данных калорий
struct MeasuredCalories: Codable {
    let quantity: Double
}

/// Объект передачи данных граммов
struct MeasuredGrams: Codable {
    let quantity: Double
}

/// Объект полученный в ходе десериализации
final class RecipeTest {
    let label: String
    let uri: String
    let image: String
    let calories: Double
    let totalTime: Double
    let totalWeight: Double
    let totalNutrients: TotalNutrients
    let ingredientLines: [String]

    init(recipe: RecipeDTO) {
        label = recipe.label
        image = recipe.image
        calories = recipe.calories
        totalTime = recipe.totalTime
        totalWeight = recipe.totalWeight
        uri = recipe.uri
        totalNutrients = recipe.totalNutrients
        ingredientLines = recipe.ingredientLines
    }
}
