// UsersMemento.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class RegisteredUsersMemento {
    private enum Constants {
        static let userMementoKey = "users"
    }

    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()

    var users: [User] {
        get {
            guard let data = UserDefaults.standard.data(forKey: Constants.userMementoKey) else { return [User]() }
            do {
                return try decoder.decode([User].self, from: data)
            } catch {
                return [User]()
            }
        }
        set {
            do {
                let data = try encoder.encode(newValue)
                UserDefaults.standard.set(data, forKey: Constants.userMementoKey)
            } catch {
                print(error)
            }
        }
    }

    init(users: [User]) {
        self.users = users
    }
}
