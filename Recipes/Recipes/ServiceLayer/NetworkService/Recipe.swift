// Recipe.swift
// Copyright © RoadMap. All rights reserved.

/// Объект получаемый в ходе десериализации
final class Recipe: Codable {
    /// Ссылка на рецепт
    let uri: String
    /// Название рецепта
    let label: String
    /// Картинка рецепта
    let image: String
    /// Кол-во калорий
    let calories: Double
    /// Время приготовления
    let totalTime: Double
    /// Вес блюда
    let totalWeight: Double
    /// Калории
    let energyCalories: Double
    /// Углеводы
    let carb: Double
    /// Жиры
    let fat: Double
    /// Белки
    let protein: Double
    /// Детальное описание рецепта
    let ingredientLines: String

    init(dto: RecipeDTO, totalNutrientsDTO: TotalNutrientsDTO) {
        label = dto.label
        image = dto.image
        calories = dto.calories
        totalTime = dto.totalTime
        uri = dto.uri
        totalWeight = dto.totalWeight
        energyCalories = totalNutrientsDTO.energyCalories?.quantity ?? 0
        carb = totalNutrientsDTO.carb?.quantity ?? 0
        fat = totalNutrientsDTO.fat?.quantity ?? 0
        protein = totalNutrientsDTO.protein?.quantity ?? 0
        ingredientLines = dto.ingredientLines.joined(separator: "\n")
    }

    init(cdRecipe: RecipeData) {
        uri = cdRecipe.uri
        image = cdRecipe.image
        label = cdRecipe.label
        totalTime = cdRecipe.totalTime
        energyCalories = cdRecipe.energyCalories
        totalWeight = cdRecipe.totalWeight
        calories = cdRecipe.calories
        carb = cdRecipe.carb
        fat = cdRecipe.fat
        protein = cdRecipe.protein
        ingredientLines = cdRecipe.ingredientLines
    }
}
