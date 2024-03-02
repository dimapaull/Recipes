// LogOutTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с переходом на разлогирование
final class LogOutTableViewCell: UITableViewCell {
    // MARK: - Constants

    enum Constants {
        static let identifier = "LogOutTableViewCell"
        static let lightGrayImage = UIImage(named: "lightGrayView")
        static let logOutImage = UIImage(named: "logout")
        static let logoutText = "Log out"
        static let verdanaSize18 = UIFont(name: "Verdana", size: 18)
        static let pointerImage = UIImage(named: "pointer")
    }

    // MARK: - Private Properties

    private let lightGrayImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = Constants.lightGrayImage
        return view
    }()

    private let logOutImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.logOutImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let logOutLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.logoutText
        label.textColor = .appDarkGray
        label.font = Constants.verdanaSize18
        return label
    }()

    private let pointerImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.pointerImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let lineView = {
        let view = UIView()
        view.backgroundColor = .appLightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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

    // MARK: = Private Methods

    private func setupView() {
        contentView.addSubview(lightGrayImageView)
        contentView.addSubview(logOutImageView)
        contentView.addSubview(logOutLabel)
        contentView.addSubview(pointerImageView)
        contentView.addSubview(lineView)
    }

    private func setupConstraints() {
        setuplightGrayImageViewConstraints()
        setupLogOutImageViewConstraints()
        setupLogOutLabelConstraints()
        setupPointerImageViewConstraints()
        setupLineViewConstraints()
    }

    private func setuplightGrayImageViewConstraints() {
        lightGrayImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        lightGrayImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        lightGrayImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        lightGrayImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
    }

    private func setupLogOutImageViewConstraints() {
        logOutImageView.centerXAnchor.constraint(equalTo: lightGrayImageView.centerXAnchor).isActive = true
        logOutImageView.centerYAnchor.constraint(equalTo: lightGrayImageView.centerYAnchor).isActive = true
        logOutImageView.heightAnchor.constraint(equalToConstant: 22.17).isActive = true
        logOutImageView.widthAnchor.constraint(equalToConstant: 23.34).isActive = true
    }

    private func setupLogOutLabelConstraints() {
        logOutLabel.leadingAnchor.constraint(equalTo: lightGrayImageView.trailingAnchor, constant: 16).isActive = true
        logOutLabel.centerYAnchor.constraint(equalTo: lightGrayImageView.centerYAnchor).isActive = true
        logOutLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        logOutLabel.widthAnchor.constraint(equalToConstant: 224).isActive = true
    }

    private func setupPointerImageViewConstraints() {
        pointerImageView.centerYAnchor.constraint(equalTo: logOutImageView.centerYAnchor).isActive = true
        pointerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -33.5).isActive = true
        pointerImageView.heightAnchor.constraint(equalToConstant: 14).isActive = true
        pointerImageView.widthAnchor.constraint(equalToConstant: 7).isActive = true
    }

    private func setupLineViewConstraints() {
        lineView.leadingAnchor.constraint(equalTo: lightGrayImageView.trailingAnchor, constant: 16).isActive = true
        lineView.topAnchor.constraint(equalTo: logOutLabel.bottomAnchor, constant: 16).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: 249).isActive = true
    }
}
