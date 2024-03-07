// CarrierState.swift
// Copyright © RoadMap. All rights reserved.

final class CarrierState {
    var state: RegisteredUsersMemento?
    var usersManager: UsersManager

    init(usersManager: UsersManager) {
        self.usersManager = usersManager
    }

    public func saveUser() {
        state = usersManager.save()
    }

    func load() {
        guard let state = state else { return }
        usersManager.load(mementoState: state)
    }
}
