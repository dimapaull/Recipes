// AuthorizationPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер для экрана авториизации
final class AuthorizationPresenter {
    // MARK: - Constants

    private enum Constants {
        static let dispatchTimeCount = 3.0
        static let bottomConstantForLogin = -43.0
    }

    // MARK: - Private Properties

    private var validateUserData = ValidateUserData()
    private weak var view: AuthorizationViewProtocol?
    private weak var authorizationCoordinator: AuthorizationCoordinator?

    // MARK: - Initializers

    required init(view: AuthorizationViewProtocol, authorizationCoordinator: AuthorizationCoordinator) {
        self.view = view
        self.authorizationCoordinator = authorizationCoordinator
        validateUserData.delegate = self
    }

    // MARK: - Public Methods

    func textFieldChanged(inMail: String?) {
        validateUserData.mail = inMail
    }

    func textFieldChanged(inPassword: String?) {
        validateUserData.password = inPassword
    }

    func securityButtonTapped(_ isSecurity: Bool) {
        if isSecurity {
            view?.showPassword()
        } else {
            view?.hidePassword()
        }
    }

    func moveViewWithKeyboard(notification: NSNotification, isKeyboardWillShow: Bool) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?
            .cgRectValue else { return }
        let keyboardHeight = keyboardSize.height
        view?.moveLoginButton(isKeyboardWillShow ? -keyboardHeight : Constants.bottomConstantForLogin)
    }
}

// MARK: - AuthorizationPresenter + DataValidable

extension AuthorizationPresenter: DataValidable {
    func dataValidChangeTo(isMailValid: Bool, isPasswordValid: Bool) {
        if isMailValid {
            view?.setupCorrectEmail()
        } else {
            view?.setupIncorrectEmail()
        }
        if isPasswordValid {
            view?.setupCorrectPassword()
        } else {
            view?.setupIncorrectPassword()
        }

        if isPasswordValid, isMailValid {
            view?.showSpinner()
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.dispatchTimeCount) {
                self.view?.stopSpinner()
                if !self.validateUserData.getValidateData() {
                    self.view?.showUnvalideDataLabel()
                } else {
                    self.authorizationCoordinator?.onFinish()
                }
            }
        }
    }
}
