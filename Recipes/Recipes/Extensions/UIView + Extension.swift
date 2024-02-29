// String+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширения для добавления тени к UIView
extension UIView {
    /// Функция с настройками слоев тени
    func makeShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 0.5
    }
}
