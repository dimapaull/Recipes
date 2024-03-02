// ProfileAvatarTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для показа всплывающего сообщения
protocol AlertableProtocol: AnyObject {
    /// Метод вызова аллерта
    func alertShow()
}

/// Ячейка с аватаркой пользователя
final class ProfileAvatarTableViewCell: UITableViewCell {
    // MARK: - Public Properties

    weak var delegate: AlertableProtocol?

    // MARK: - Constants

    enum Constants {
        static let identifier = "ProfileAvatarTableViewCell"
        static let avatarImage = UIImage(named: "avatar")
        static let profilelabelText = "Surname Name"
        static let verdanaBoldSize25 = UIFont(name: "Verdana-Bold", size: 25)
        static let pencilButtonImage = UIImage(named: "pencil")
    }

    // MARK: - Private Properties

    private let profileImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.avatarImage
        return imageView
    }()

    private let profileFullNameLabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = Constants.profilelabelText
        label.textColor = .appDarkGray
        label.textAlignment = .center
        label.font = Constants.verdanaBoldSize25
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var pencilButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Constants.pencilButtonImage, for: .normal)
        button.addTarget(self, action: #selector(pencilButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setupConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupView()
        setupConstraints()
    }

    // MARK: - Private Methods

    private func setupView() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(profileFullNameLabel)
        contentView.addSubview(pencilButton)
    }

    private func setupConstraints() {
        setupProfileImageViewConstraints()
        profileFullNameLabelConstraints()
        pencilImageViewConstraints()
    }

    private func setupProfileImageViewConstraints() {
        profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
    }

    private func profileFullNameLabelConstraints() {
        profileFullNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 26).isActive = true
        profileFullNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 51).isActive = true
        profileFullNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        profileFullNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        profileFullNameLabel.widthAnchor.constraint(equalToConstant: 256).isActive = true
    }

    private func pencilImageViewConstraints() {
        pencilButton.leadingAnchor.constraint(
            equalTo: profileFullNameLabel.trailingAnchor, constant: -11
        ).isActive = true
        pencilButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -51).isActive = true
        pencilButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        pencilButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        pencilButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
    }

    @objc private func pencilButtonTapped() {
        delegate?.alertShow()
    }
}

extension ProfileAvatarTableViewCell: ChangebleTitleProtocol {
    func changeTitleFullName(title: String) {
        profileFullNameLabel.text = title
    }
}
