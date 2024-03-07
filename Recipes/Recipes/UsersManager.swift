// UsersManager.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class UsersManager {
    static let shared = UsersManager()

    var users: [User] = []

    func save() -> RegisteredUsersMemento {
        RegisteredUsersMemento(users: users)
    }

    func load(mementoState: RegisteredUsersMemento) {
        users = mementoState.users
    }
}
