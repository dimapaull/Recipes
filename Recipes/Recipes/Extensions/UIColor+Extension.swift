// UIColor+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширения для цветов UIColor
extension UIColor {
    /// Словарь для добавления цветов
    static var colorStoreMap: [String: UIColor] = [:]
    /// Функция проверки цвета в словаре
    /// - Parameter red: Оттенок красного
    /// - Parameter green: Оттенок зеленого
    /// - Parameter blue: Оттенок синего
    /// - Parameter alpha: Прозрачность
    /// - Returns: Цвет
    static func rgba(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        let key = "\(red)\(green)\(blue)\(alpha)"
        if let color = colorStoreMap[key] {
            return color
        }

        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        colorStoreMap[key] = color
        return color
    }
}
