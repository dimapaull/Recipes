// Recipe.swift
// Copyright © RoadMap. All rights reserved.

/// Объект получаемый в ходе десериализации
final class Recipe {
    let uri: String
    let label: String
    let image: String
    let calories: Double
    let totalTime: Double

    init(dto: RecipeDTO) {
        label = dto.label
        image = dto.image
        calories = dto.calories
        totalTime = dto.totalTime
        uri = dto.uri
    }
}
