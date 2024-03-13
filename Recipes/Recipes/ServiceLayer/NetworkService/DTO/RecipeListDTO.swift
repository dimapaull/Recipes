// RecipeListDTO.swift
// Copyright © RoadMap. All rights reserved.

/// Объект передачи данных списка рецептов
struct RecipeListDTO: Codable {
    let hits: [DishRecipeDTO]
}
