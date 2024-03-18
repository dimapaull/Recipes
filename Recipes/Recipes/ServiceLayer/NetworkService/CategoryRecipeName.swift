// CategoryRecipeName.swift
// Copyright © RoadMap. All rights reserved.

/// Выбор категории рецептов
enum CategoryRecipeName: String, Codable {
    /// Салат
    case salad = "Salad"
    /// Суп
    case soup = "Soup"
    /// Рыба
    case fish = "Fish"
    /// Мясо
    case meat = "Meat"
    /// Курица
    case chicken = "Chicken"
    /// Вегетарианская еда
    case sideDish = "vegetarian"
    /// Панкейки
    case pancake = "Pancake"
    /// Напитки
    case drinks = "Drinks"
    /// Десерты
    case desserts = "Desserts"

    /// Возвращает строковое представление типа блюда для указания в запросе.
    var stringValue: String {
        switch self {
        case .salad:
            "salad"
        case .soup:
            "soup"
        case .chicken, .meat, .fish, .sideDish:
            "main course"
        case .pancake:
            "pancake"
        case .drinks:
            "drinks"
        case .desserts:
            "desserts"
        }
    }
}
