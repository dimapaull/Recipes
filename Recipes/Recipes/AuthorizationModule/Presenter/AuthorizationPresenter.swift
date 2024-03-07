// AuthorizationPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер для экрана авториизации
final class AuthorizationPresenter {
    enum UserValidateState {
        case newUser
        case notValidPassword
        case validUser
    }

    // MARK: - Constants

    private enum Constants {
        static let dispatchTimeCount = 3.0
        static let bottomConstantForLogin = -43.0
    }

    // MARK: - Private Properties

    private var validateUserData = ValidateUserData()
    private weak var view: AuthorizationViewProtocol?
    private weak var authorizationCoordinator: AuthorizationCoordinator?
    private var carrierState: CarrierState?

    // MARK: - Initializers

    required init(
        view: AuthorizationViewProtocol,
        authorizationCoordinator: AuthorizationCoordinator,
        carrierState: CarrierState
    ) {
        self.view = view
        self.authorizationCoordinator = authorizationCoordinator
        validateUserData.delegate = self
        self.carrierState = carrierState
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

extension AuthorizationPresenter: DataValidableProtocol {
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

                if self.validateUserData.getValidateData().valid {
                    self.carrierState?.saveUser()
                    self.carrierState?.load()

                    let user = User(
                        login: self.validateUserData.getValidateData().login ?? "",
                        password: self.validateUserData.getValidateData().password ?? ""
                    )

                    switch self.checkRegisterUser(user).0 {
                    case .newUser:
                        self.carrierState?.usersManager.users.append(user)
                        self.carrierState?.saveUser()
                    case .notValidPassword:
                        self.view?.showUnvalideDataLabel()
                        return
                    case .validUser:
                        break
                    }
                    self.carrierState?.usersManager.setCurrentUser(self.checkRegisterUser(user).1)
                    self.authorizationCoordinator?.onFinish()
                }
            }
        }
    }

    func checkRegisterUser(_ user: User) -> (UserValidateState, User) {
        if let safeRegisteredUsers = carrierState?.usersManager.users {
            for registerUser in safeRegisteredUsers {
                if registerUser.login == user.login, registerUser.password == user.password {
                    return (.validUser, registerUser)
                } else if registerUser.login == user.login, registerUser.password != user.password {
                    return (.notValidPassword, registerUser)
                }
            }
        }
        return (.newUser, user)
    }
}
