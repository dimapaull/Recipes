// ProfileView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol ChangebleTitleProtocol: AnyObject {
    func changeTitleFullName(title: String)
}

/// Экран профиля пользователя
final class ProfileView: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let alertTitle = "Are you sure you want to log out?"
        static let yesAlert = "Yes"
        static let cancelAlert = "Cancel"
        static let okAlert = "Ok"
        static let titleAlert = "Change your name and surname"
        static let placeholderText = "Name Surname"
        static let twoHundredSeventy = 270
        static let seventy = 70
    }

    enum TypeCells {
        case profileAvatar
        case profileBonuses
        case profilePolicy
        case profileLogOut
    }

    // MARK: - Visual Components

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Public Properties

    var presenter: ProfilePresenter?

    // MARK: - Private Properties

    private let typeCells: [TypeCells] = [.profileAvatar, .profileBonuses, .profilePolicy, .profileLogOut]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureUI()
    }

    // MARK: - Private Methods

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            ProfileAvatarTableViewCell.self,
            forCellReuseIdentifier:
            ProfileAvatarTableViewCell.Constants.identifier
        )
        tableView.register(
            ProfileBonusesTableViewCell.self,
            forCellReuseIdentifier:
            ProfileBonusesTableViewCell.Constants.identifier
        )
        tableView.register(
            ProfilePolicyTableViewCell.self,
            forCellReuseIdentifier:
            ProfilePolicyTableViewCell.Constants.identifier
        )
        tableView.register(
            LogOutTableViewCell.self,
            forCellReuseIdentifier:
            LogOutTableViewCell.Constants.identifier
        )
    }

    private func configureUI() {
        view.backgroundColor = .white
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    private func logOutAlert() {
        let alert = UIAlertController(title: Constants.alertTitle, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.yesAlert, style: .default)
        let actionCancel = UIAlertAction(title: Constants.cancelAlert, style: .default)
        alert.addAction(okAction)
        alert.addAction(actionCancel)
        present(alert, animated: true)
    }
}

// MARK: - ProfileView + UITableViewDataSource, UITableViewDelegate

extension ProfileView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = typeCells[indexPath.section]
        switch cells {
        case .profileAvatar:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileAvatarTableViewCell.Constants.identifier,
                for: indexPath
            )
                as? ProfileAvatarTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            presenter?.cellDelegate = cell
            return cell
        case .profileBonuses:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileBonusesTableViewCell.Constants.identifier,
                for: indexPath
            )
                as? ProfileBonusesTableViewCell else { return UITableViewCell() }
            return cell
        case .profilePolicy:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfilePolicyTableViewCell.Constants.identifier,
                for: indexPath
            )
                as? ProfilePolicyTableViewCell else { return UITableViewCell() }
            return cell
        case .profileLogOut:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: LogOutTableViewCell.Constants.identifier,
                for: indexPath
            )
                as? LogOutTableViewCell else { return UITableViewCell() }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let cells = typeCells[indexPath.section]
        switch cells {
        case .profileAvatar:
            print("profileAvatar")
        case .profileBonuses:
            let bonusesView = BonusesView()
            bonusesView.profilePresenter = presenter
            if let sheet = bonusesView.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.preferredCornerRadius = 30
            }
            present(bonusesView, animated: true)
        case .profilePolicy:
            let policyView = PolicyView()
            policyView.modalPresentationStyle = .automatic
            policyView.sheetPresentationController?.preferredCornerRadius = 30
            present(policyView, animated: true)
        case .profileLogOut:
            logOutAlert()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cells = typeCells[indexPath.section]
        switch cells {
        case .profileAvatar:
            return CGFloat(Constants.twoHundredSeventy)
        case .profileBonuses:
            return CGFloat(Constants.seventy)
        case .profilePolicy:
            return CGFloat(Constants.seventy)
        case .profileLogOut:
            return CGFloat(Constants.seventy)
        }
    }
}

// MARK: - Расширение класса для вывода аллерта

extension ProfileView: AlertableProtocol {
    func alertShow() {
        let alert = UIAlertController(title: Constants.titleAlert, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.okAlert, style: .cancel) { [weak self] _ in
            guard let fullName = alert.textFields?.first?.text else { return }
            self?.presenter?.allertChangeFullName(title: fullName)
        }
        let actionCancel = UIAlertAction(title: Constants.cancelAlert, style: .default)
        alert.addTextField { textField in
            textField.placeholder = Constants.placeholderText
        }
        alert.addAction(okAction)
        alert.addAction(actionCancel)
        present(alert, animated: true)
    }
}
