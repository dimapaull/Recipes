// RecipeDetailImage.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Название и фото рецепта
struct RecipeDetail {
    /// Название рецепта
    let title: String
    /// Изображение рецепта
    let imageName: String
    /// Вес блюда
    let dishWeight: Int
    /// Время приготовления
    let cookingTime: Int
    /// Килокалории
    let kilocalories: Int
    /// Углеводы
    let carbohydrates: Double
    /// Жиры
    let fats: Double
    /// Протеины
    let proteins: Double
    /// Описание рецепта
    let description: String
}
