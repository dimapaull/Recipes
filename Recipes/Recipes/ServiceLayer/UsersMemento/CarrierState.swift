// CarrierState.swift
// Copyright © RoadMap. All rights reserved.

/// Управляет хранилищем и менеджером
final class CarrierState {
    // MARK: - Public Properties

    var state: RegisteredUsersMemento?
    var usersManager: UsersManager

    // MARK: - Initializers

    init(usersManager: UsersManager) {
        self.usersManager = usersManager
    }

    // MARK: - Public Methods

    func saveUser() {
        state = usersManager.save()
    }

    func load() {
        guard let state = state else { return }
        usersManager.load(mementoState: state)
    }
}
