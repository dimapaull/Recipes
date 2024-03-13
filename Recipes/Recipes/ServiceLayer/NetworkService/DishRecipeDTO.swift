// DishRecipeDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Объект передачи данных списка рецептов
struct RecipeListDTO: Codable {
    let hits: [DishRecipeDTO]
}

/// Объект передачи данных рецепта
struct DishRecipeDTO: Codable {
    let recipe: RecipeDTO
}

/// Объект передачи данных рецепта детального
struct RecipeDTO: Codable {
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
struct TotalNutrients: Codable {
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

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(energyCalories, forKey: .energyCalories)
        try container.encode(carb, forKey: .carbGram)
        try container.encode(fat, forKey: .fatGram)
        try container.encode(protein, forKey: .protein)
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

/// Объект получаемый в ходе десериализации
final class RecipeTest {
    // MARK: - Public Properties

    let uri: String

    // MARK: - Private Properties

    private let label: String
    private let image: String
    private let calories: Double
    private let totalTime: Double
    private let totalWeight: Double
    private let totalNutrients: TotalNutrients
    private let ingredientLines: [String]

    // MARK: - Initializers

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
