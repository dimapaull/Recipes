// UsersMemento.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Моментальное хранилище, которое записывает данные на устройство
final class RegisteredUsersMemento {
    // MARK: - Constants

    private enum Constants {
        static let userMementoKey = "users"
    }
    
    //MARK: Public Property
    
    var users: [User] {
        get {
            guard let data = UserDefaults.standard.data(forKey: Constants.userMementoKey) else { return [User]() }
            do {
                let decodedUsers = try decoder.decode([User].self, from: data)
                print(decodedUsers)
                return decodedUsers
            } catch {
                return [User]()
            }
        }
        set {
            do {
                guard !newValue.isEmpty else {
                    print("Attempted to save an empty array of users.")
                    return
                }
                print(newValue)
                let data = try encoder.encode(newValue)
                UserDefaults.standard.set(data, forKey: Constants.userMementoKey)
                UserDefaults.standard.synchronize()
            } catch {
                print("Encoding error:", error)
            }
        }
    }

    // MARK: - Private Properties

    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()

    
    // MARK: - Initializers

    init(users: [User]) {
        self.users = users
    }
}
