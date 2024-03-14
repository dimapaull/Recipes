// Recipe.swift
// Copyright © RoadMap. All rights reserved.

/// Объект получаемый в ходе десериализации
final class Recipe {
    let uri: String
    /// Название рецепта
    let label: String
    /// Картинка рецепта
    let image: String
    /// Кол-во калорий
    let calories: Double
    /// Время приготовления
    let totalTime: Double

    init(dto: RecipeDTO) {
        label = dto.label
        image = dto.image
        calories = dto.calories
        totalTime = dto.totalTime
        uri = dto.uri
    }
}
