// Recipe.swift
// Copyright © RoadMap. All rights reserved.

/// Объект получаемый в ходе десериализации
final class Recipe {
    // MARK: - Public Properties

    let uri: String

    // MARK: - Private Properties

    private let label: String
    private let image: String
    private let calories: Double
    private let totalTime: Double
    private let totalWeight: Double
    private let totalNutrients: TotalNutrientsDTO
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
