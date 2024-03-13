// RecipeListDTO.swift
// Copyright © RoadMap. All rights reserved.

/// Объект передачи данных списка рецептов
struct RecipeListDTO: Codable {
    /// Рецепты
    let hits: [DishRecipeDTO]
}
