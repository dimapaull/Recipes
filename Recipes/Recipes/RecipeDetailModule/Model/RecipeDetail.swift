// RecipeDetail.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Название и фото рецепта
struct RecipeDetail: Codable {
    /// Название рецепта
    let title: String
    /// Изображение рецепта
    let imageName: String
    /// Вес блюда
    let dishWeight: String
    /// Время приготовления
    let cookingTime: Int
    /// Килокалории
    let kilocalories: Int
    /// Углеводы
    let carbohydrates: String
    /// Жиры
    let fats: String
    /// Протеины
    let proteins: String
    /// Описание рецепта
    let description: String
}
