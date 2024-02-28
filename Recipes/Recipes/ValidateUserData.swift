// ValidateUserData.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Валидация введенных данных пользователя
protocol DataValidable: AnyObject {
    /// Метод, возвращающий булевое значение, указывающее на валидность логина и пароля
    func dataValidChangeTo(isMailValid: Bool, isPasswordValid: Bool)
}

/// Проверяет данные пользователя на корректность
final class ValidateUserData {
    // MARK: - Constants

    private enum Constants {
        static let minimumSymbols = 8
        static let needFirstSymbol = "@"
        static let unvalidMail = "1@1.com"
        static let unvalidPassword = "11111111"
    }

    // MARK: - Public Properties

    /// Логин пользователя. Проверка на корректность при изменении
    var mail: String? {
        didSet {
            if let safeMail = mail, safeMail.lowercased().isValidEmail() {
                isMailValid = true
            } else {
                isMailValid = false
            }
            delegate?.dataValidChangeTo(isMailValid: isMailValid, isPasswordValid: isPasswordValid)
        }
    }

    /// Пароль пользователя. Проверка на корректность при изменении
    var password: String? {
        didSet {
            if password?.count ?? 0 >= Constants.minimumSymbols {
                isPasswordValid = true
            } else {
                isPasswordValid = false
            }
            delegate?.dataValidChangeTo(isMailValid: isMailValid, isPasswordValid: isPasswordValid)
        }
    }

    func getValidateData() -> Bool {
        if mail == Constants.unvalidMail, password == Constants.unvalidPassword {
            return false
        }
        return true
    }

    weak var delegate: DataValidable?

    // MARK: - Private Properties

    private var isMailValid = false
    private var isPasswordValid = false
}
