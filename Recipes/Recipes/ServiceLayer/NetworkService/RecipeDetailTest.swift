// RecipeDetailTest.swift
// Copyright © RoadMap. All rights reserved.

final class RecipeDetailTest {
    private let label: String
    private let image: String
    private let calories: Double
    private let totalTime: Double
    private let totalWeight: Double
    private let totalNutrients: TotalNutrientsDTO
    private let ingredientLines: [String]

    init(dto: RecipeDTO) {
        label = dto.label
        image = dto.image
        calories = dto.calories
        totalTime = dto.totalTime
        totalWeight = dto.totalWeight
        totalNutrients = dto.totalNutrients
        ingredientLines = dto.ingredientLines
    }
}
