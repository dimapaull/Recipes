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
}
