// String+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Расширения для использования маски почты
extension String {
    /// Валиадация почты
    /// - Returns: При успешной валидации вернет true
    func isValidEmail() -> Bool {
        let firstPattern = "[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}"
        let secondPattern = "[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let regex = try? NSRegularExpression(
            pattern: firstPattern + secondPattern,
            options: .caseInsensitive
        )
        return regex?.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
