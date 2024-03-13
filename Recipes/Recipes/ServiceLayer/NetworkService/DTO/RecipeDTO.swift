// RecipeDTO.swift
// Copyright © RoadMap. All rights reserved.

/// Объект передачи данных рецепта детального
struct RecipeDTO: Codable {
    /// Ссылка на детальную информацию об рецепте
    let uri: String
    /// Название рецепта
    let label: String
    /// Ссылка на изображение рецепта
    let image: String
    /// Количество калорий
    let calories: Double
    /// Время приготовления
    let totalTime: Double
    /// Масса
    let totalWeight: Double
    /// Белки, жиры, углеводы
    let totalNutrients: TotalNutrientsDTO
    /// Ингридиенты
    let ingredientLines: [String]
}
