// String+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширения для добавления тени к UIView
extension UIView {
    /// Функция с настройками слоев тени
    func makeShadow() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: -1, height: 5)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2.0
        layer.masksToBounds = false
    }
}
