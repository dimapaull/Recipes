// UIFont+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширения для использования новых шрифтов
extension UIFont {
    /// Шрифт Verdana
    /// - Parameter ofSize: Размер необходимого шрифта
    /// - Returns: Шрифт Verdana
    static func verdana(ofSize: CGFloat) -> UIFont {
        UIFont(name: "Verdana", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
    }

    /// Шрифт Verdana Bold
    /// - Parameter ofSize: Размер необходимого шрифта
    /// - Returns: Шрифт Verdana Bold
    static func verdanaBold(ofSize: CGFloat) -> UIFont {
        UIFont(name: "Verdana-Bold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
    }

    /// Словарь для шрифтов
    static var fontStoreMap: [String: UIFont] = [:]
    /// Функция проверки цвета в словаре
    /// - Parameter name: Название необходимого шрифта
    /// - Parameter size: Размер необходимого шрифта
    /// - Returns: Шрифт
    static func font(name: String, size: CGFloat) -> UIFont? {
        let keyFont = "\(name)\(size)"
        if let font = fontStoreMap[keyFont] {
            return font
        }
        let newFont = UIFont(name: name, size: size)
        fontStoreMap[keyFont] = newFont
        return newFont
    }
}
