// Recipe.swift
// Copyright © RoadMap. All rights reserved.

/// Объект получаемый в ходе десериализации
final class Recipe {
    let uri: String
    /// Название рецепта
    private let label: String
    /// Картинка рецепта
    private let image: String
    /// Кол-во калорий
    private let calories: Double
    /// Время приготовления
    private let totalTime: Double

    init(dto: RecipeDTO) {
        label = dto.label
        image = dto.image
        calories = dto.calories
        totalTime = dto.totalTime
        uri = dto.uri
    }
}
