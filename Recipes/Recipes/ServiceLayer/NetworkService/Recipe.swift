// Recipe.swift
// Copyright © RoadMap. All rights reserved.

/// Объект получаемый в ходе десериализации
final class Recipe {
    let uri: String
    private let label: String
    private let image: String
    private let calories: Double
    private let totalTime: Double

    init(dto: RecipeDTO) {
        label = dto.label
        image = dto.image
        calories = dto.calories
        totalTime = dto.totalTime
        uri = dto.uri
    }
}
