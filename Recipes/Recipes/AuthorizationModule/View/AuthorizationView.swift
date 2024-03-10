// AuthorizationView.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

protocol AuthorizationViewProtocol: AnyObject {
    /// Устновка неверного заполнения поля почты
    func setupIncorrectEmail()
    /// Устновка верного заполнения поля почты
    func setupCorrectEmail()
    /// Устновка неверного заполнения поля пароля
    func setupIncorrectPassword()
    /// Устновка верного заполнения поля пароля
    func setupCorrectPassword()
    /// Включение видимости пароля
    func showPassword()
    /// Выключение видимости пароля
    func hidePassword()
    /// Включение индикатора загрузки
    func showSpinner()
    /// Перемещение логин на определенное значние нижнего якоря
    func moveLoginButton(_ constant: CGFloat)
    /// Остановка индиктора загрузки
    func stopSpinner()
    /// Показ и запуск анимации лэйбла, который говорит о невалидности введенных данных
    func showUnvalideDataLabel()
}

/// Экран авторизации пользователя
final class AuthorizationView: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let loginText = "Login"
        static let emailText = "Email Address"
        static let passwordText = "Password"
        static let enterEmailText = "Enter Email Address"
        static let enterPasswordText = "Enter Password"
        static let incorrectEmailText = "Incorrect format"
        static let incorrectPasswordText = "You entered the wrong password"
        static let unvaliableText = "Please check the accuracy of the entered credentials."
        static let titleSection = "Логин"
    }

    // MARK: - Visual Components

    private let emailLabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = Constants.emailText
        label.font = .verdanaBold(ofSize: 18)
        label.textColor = .appDarkGray
        return label
    }()

    private let incorrectEmailLabel = {
        let label = UILabel()
        label.isHidden = true
        label.textAlignment = .left
        label.text = Constants.incorrectEmailText
        label.font = .verdanaBold(ofSize: 12)
        label.textColor = .appRed
        return label
    }()

    private let passwordLabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = Constants.passwordText
        label.font = .verdanaBold(ofSize: 18)
        label.textColor = .appDarkGray
        return label
    }()

    private let incorrectPasswordLabel = {
        let label = UILabel()
        label.isHidden = true
        label.textAlignment = .left
        label.text = Constants.incorrectPasswordText
        label.font = .verdanaBold(ofSize: 12)
        label.textColor = .appRed
        return label
    }()

    private let spinnerActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.color = .white
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.isHidden = false
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()

    private let unvaliableUserLabel = {
        let label = PaddingLabel()
        label.text = Constants.unvaliableText
        label.isHidden = true
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        label.textAlignment = .left
        label.text = Constants.unvaliableText
        label.font = .verdana(ofSize: 18)
        label.textColor = .white
        label.numberOfLines = 2
        label.backgroundColor = .appRed
        label.contentMode = .right
        return label
    }()

    private lazy var emailTextField = {
        let textField = UITextField()
        textField.leftViewMode = .always
        textField.rightViewMode = .whileEditing
        textField.keyboardType = .emailAddress
        textField.delegate = self
        textField.placeholder = Constants.enterEmailText
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.addTarget(self, action: #selector(textDidChangeInMail), for: .editingDidEnd)
        return textField
    }()

    private lazy var passwordTextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.isSecureTextEntry = true
        textField.placeholder = Constants.enterPasswordText
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        textField.layer.borderColor = UIColor.lightGray.cgColor
        return textField
    }()

    private lazy var loginButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.setTitle(Constants.loginText, for: .normal)
        button.titleLabel?.font = UIFont.verdana(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .appDarkGreen
        button.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        return button
    }()

    private lazy var hideButton = {
        let button = UIButton(frame: CGRect(x: 15, y: 0, width: 22, height: 19))
        button.setImage(.hidePassword, for: .normal)
        button.addTarget(self, action: #selector(showPasswordPressed), for: .touchUpInside)
        return button
    }()

    // MARK: - Public Properties

    var presenter: AuthorizationPresenter?

    // MARK: - Private Properties

    private lazy var loginButtonBottomConstraint = self.loginButton.bottomAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.bottomAnchor,
        constant: -43
    )

    private lazy var unvaliabLabelBottomConstraint = self.unvaliableUserLabel.bottomAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.bottomAnchor,
        constant: 80
    )

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configurenavigationBar()
        configureUI()
        addKeyboardObserver()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.textTitleSection(titleSection: Constants.titleSection)
    }

    // MARK: - Private Methods

    private func configurenavigationBar() {
        title = Constants.loginText
        navigationController?.navigationBar.prefersLargeTitles = true

        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.verdanaBold(ofSize: 28),
            NSAttributedString.Key.foregroundColor: UIColor.appDarkGray
        ]
    }

    private func configureUI() {
        view.backgroundColor = .white
        addMainViewGradient()
        addSubviews()
        setupTapMainViewRecognizer()
        setupLoginButtonAnchors()
        setupLabelAnchors()
        setupTextFieldAnchors()
        setupIncorrectLabelAnchors()
        configurePasswordTextField()
        configureEmailTextField()
        setupActivityIndicatorView()
        setupUnvaliableLabelAnchors()
    }

    private func addSubviews() {
        for item in [
            emailLabel,
            emailTextField,
            passwordLabel,
            passwordTextField,
            loginButton,
            incorrectEmailLabel,
            incorrectPasswordLabel,
            unvaliableUserLabel
        ] {
            item.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(item)
        }
    }

    private func setupActivityIndicatorView() {
        loginButton.addSubview(spinnerActivityIndicatorView)
        spinnerActivityIndicatorView.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor).isActive = true
        spinnerActivityIndicatorView.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor).isActive = true
    }

    private func addMainViewGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.white.cgColor, UIColor.appGradient.cgColor]
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
    }

    private func addKeyboardObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDidHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private func setupTapMainViewRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapRecognizer)
    }

    private func configureEmailTextField() {
        let leftImageView = UIImageView(frame: CGRect(x: 15, y: 0, width: 20, height: 16))
        leftImageView.contentMode = .scaleAspectFill
        leftImageView.image = .email

        let leftBackView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 16))
        leftBackView.addSubview(leftImageView)

        emailTextField.leftView = leftBackView

        let rightButton = UIButton(frame: CGRect(x: 12, y: 0, width: 18, height: 18))
        rightButton.setImage(.clearMail, for: .normal)
        rightButton.addTarget(self, action: #selector(clearMailPressed), for: .touchUpInside)

        let rightBackView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 20))
        rightBackView.addSubview(rightButton)

        emailTextField.rightView = rightBackView
    }

    private func configurePasswordTextField() {
        let imageView = UIImageView(frame: CGRect(x: 15, y: 0, width: 16, height: 21))
        imageView.contentMode = .scaleAspectFill
        imageView.image = .password

        let imageBackView = UIView(frame: CGRect(x: 0, y: 0, width: 48, height: 21))
        imageBackView.addSubview(imageView)

        let buttonBackView = UIView(frame: CGRect(x: 0, y: 0, width: 49, height: 19))
        buttonBackView.addSubview(hideButton)

        passwordTextField.leftView = imageBackView
        passwordTextField.rightView = buttonBackView
    }

    private func setupLoginButtonAnchors() {
        loginButtonBottomConstraint.isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }

    private func setupUnvaliableLabelAnchors() {
        unvaliableUserLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        unvaliableUserLabel.heightAnchor.constraint(equalToConstant: 87).isActive = true
        unvaliableUserLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        unvaliableUserLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        unvaliabLabelBottomConstraint.isActive = true
    }

    private func setupLabelAnchors() {
        emailLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
            .isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
        emailLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true

        passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 23)
            .isActive = true
        passwordLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
        passwordLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }

    private func setupTextFieldAnchors() {
        emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 6)
            .isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 6)
            .isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }

    private func setupIncorrectLabelAnchors() {
        incorrectEmailLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor)
            .isActive = true
        incorrectEmailLabel.heightAnchor.constraint(equalToConstant: 19).isActive = true
        incorrectEmailLabel.widthAnchor.constraint(equalToConstant: 230).isActive = true
        incorrectEmailLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor).isActive = true

        incorrectPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor)
            .isActive = true
        incorrectPasswordLabel.heightAnchor.constraint(equalToConstant: 19).isActive = true
        incorrectPasswordLabel.widthAnchor.constraint(equalToConstant: 230).isActive = true
        incorrectPasswordLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor).isActive = true
    }

    @objc private func showPasswordPressed() {
        presenter?.securityButtonTapped(passwordTextField.isSecureTextEntry)
    }

    @objc private func clearMailPressed() {
        emailTextField.text = ""
        setupIncorrectEmail()
    }

    @objc private func viewTapped() {
        view.endEditing(true)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        presenter?.moveViewWithKeyboard(notification: notification, isKeyboardWillShow: true)
    }

    @objc private func keyboardDidHide(notification: NSNotification) {
        presenter?.moveViewWithKeyboard(notification: notification, isKeyboardWillShow: false)
    }

    @objc private func textDidChangeInMail(_ sender: UITextField) {
        presenter?.textFieldChanged(inMail: sender.text)
    }

    @objc private func loginPressed() {
        presenter?.textFieldChanged(inPassword: passwordTextField.text)
    }
}

// MARK: - AuthorizationView + UITextFieldDelegate

extension AuthorizationView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

// MARK: - AuthorizationView + AuthorizationViewProtocol

extension AuthorizationView: AuthorizationViewProtocol {
    func setupIncorrectEmail() {
        emailTextField.layer.borderColor = UIColor.appRed.cgColor
        incorrectEmailLabel.isHidden = false
        emailLabel.textColor = .appRed
    }

    func setupCorrectEmail() {
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        incorrectEmailLabel.isHidden = true
        emailLabel.textColor = .appDarkGray
    }

    func setupIncorrectPassword() {
        passwordTextField.layer.borderColor = UIColor.appRed.cgColor
        incorrectPasswordLabel.isHidden = false
        passwordLabel.textColor = .appRed
    }

    func setupCorrectPassword() {
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        incorrectPasswordLabel.isHidden = true
        passwordLabel.textColor = .appDarkGray
    }

    func showPassword() {
        passwordTextField.isSecureTextEntry = false
        hideButton.setImage(.showPassword, for: .normal)
    }

    func hidePassword() {
        passwordTextField.isSecureTextEntry = true
        hideButton.setImage(.hidePassword, for: .normal)
    }

    func moveLoginButton(_ constant: CGFloat) {
        loginButtonBottomConstraint.constant = constant
        view.layoutIfNeeded()
    }

    func showSpinner() {
        loginButton.setTitle("", for: .normal)
        spinnerActivityIndicatorView.startAnimating()
    }

    func stopSpinner() {
        loginButton.setTitle(Constants.loginText, for: .normal)
        spinnerActivityIndicatorView.stopAnimating()
    }

    func showUnvalideDataLabel() {
        unvaliableUserLabel.isHidden = false
        UIView.animate(withDuration: 2) {
            self.unvaliabLabelBottomConstraint.constant = -83
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.unvaliableUserLabel.isHidden = true
            self.unvaliabLabelBottomConstraint.constant = 100
        }
    }
}
