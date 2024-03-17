// UsersManager.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import KeychainSwift

/// Менеджер хранилища
final class UsersManager {
    // MARK: - Types

    static let shared = UsersManager()

    // MARK: - Constants

    private enum Constants {
        static let currentUserKey = "currentUser"
    }

    // MARK: - Public Properties

    var users: [User] = []

    // MARK: - Private Properties

    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()

    // MARK: - Public Methods

    func save() -> RegisteredUsersMemento {
        RegisteredUsersMemento(users: users)
    }

    func load(mementoState: RegisteredUsersMemento) {
        users = mementoState.users
    }

    func getCurrentUser() -> User? {
        guard let data = KeychainSwift().getData(Constants.currentUserKey) else { return nil }

        do {
            let decodedUser = try decoder.decode(User.self, from: data)
            return decodedUser
        } catch {
            return nil
        }
    }

    func setCurrentUser(_ user: User) {
        do {
            let data = try encoder.encode(user)
            KeychainSwift().set(data, forKey: Constants.currentUserKey)
        } catch {
            print("Encoding error:", error)
        }
    }

    func setProfileUserImage(_ image: Data) {
        if var user = getCurrentUser() {
            user.profileImage = image
            setCurrentUser(user)
            updateUsersStore()
        }
    }

    func setUserName(_ name: String) {
        if var user = getCurrentUser() {
            user.userName = name
            setCurrentUser(user)
            updateUsersStore()
        }
    }

    // MARK: - Private Methods

    private func updateUsersStore() {
        if let user = getCurrentUser() {
            for (index, storeUser) in users.enumerated() where storeUser.login == user.login {
                users.remove(at: index)
                users.append(user)
            }
        }
    }
}
