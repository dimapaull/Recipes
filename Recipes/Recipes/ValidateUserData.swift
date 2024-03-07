// ValidateUserData.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Валидация введенных данных пользователя
protocol DataValidableProtocol: AnyObject {
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

    func getValidateData() -> (valid: Bool, login: String?, password: String?) {
        if mail == Constants.unvalidMail, password == Constants.unvalidPassword {
            return (valid: false, login: nil, password: nil)
        }
        return (valid: true, login: mail, password: password)
    }

    weak var delegate: DataValidableProtocol?

    // MARK: - Private Properties

    private var isMailValid = false
    private var isPasswordValid = false
}
