// User.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Описание пользователя
struct User: Codable, Equatable {
    /// Логин
    let login: String
    /// Пароль
    let password: String
    /// Фото профиля
    var profileImage: Data?
    /// Имя
    var userName: String?
}
