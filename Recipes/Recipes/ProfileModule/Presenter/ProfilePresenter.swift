// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер для профиля
final class ProfilePresenter {
    // MARK: - Private Properties

    private weak var view: ProfileViewProtocol?
    private weak var profileCoordinator: ProfileCoordinator?
    weak var cellDelegate: ChangebleTitleProtocol?

    // MARK: - Initializers

    required init(view: ProfileViewProtocol, profileCoordinator: ProfileCoordinator) {
        self.view = view
        self.profileCoordinator = profileCoordinator
    }

    func bonusesButtonCloseTapped(view: BonusesView) {
        view.dismiss(animated: true)
    }

    func allertChangeFullName(title: String) {
        cellDelegate?.changeTitleFullName(title: title)
    }

    func allertChangeIamge(image: UIImage) {
        cellDelegate?.changeImageView(image: image)
    }
}
