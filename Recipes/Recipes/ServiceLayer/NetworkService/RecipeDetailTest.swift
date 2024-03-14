// RecipeDetailTest.swift
// Copyright © RoadMap. All rights reserved.

final class RecipeDetailTest {
    let label: String
    let image: String
    let calories: Double
    let totalTime: Double
    let totalWeight: Double
    let totalNutrients: TotalNutrientsDTO
    let ingredientLines: [String]

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
