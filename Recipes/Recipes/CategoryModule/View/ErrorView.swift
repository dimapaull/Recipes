// ErrorView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol ErrorViewDelegateProtocol {
    func reload()
}

final class ErrorView: UIView {
    private enum Constants {
        static let errorText = "Failed to load data"
        static let emptyText = "Start typing text"
        static let reloadText = "Reload"
    }

    // MARK: - Visual Components

    private let logoImageView = {
        let imageView = UIImageView()
        imageView.image = .bolt
        imageView.contentMode = .center
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = .appError
        imageView.tintColor = .black
        return imageView
    }()

    private let errorTitleLabel = {
        let label = UILabel()
        label.font = .verdana(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .center
        label.backgroundColor = .white
        return label
    }()

    private lazy var reloadButton = {
        let button = UIButton()
        button.setTitle(Constants.reloadText, for: .normal)
        button.setImage(UIImage.findReplace, for: .normal)
        button.layer.cornerRadius = 12
        button.setTitleColor(.appErrorButton, for: .normal)
        button.backgroundColor = .appError
        button.addTarget(self, action: #selector(reloadButtonPressed), for: .touchUpInside)
        return button
    }()

    var delegate: ErrorViewDelegateProtocol?

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        setupConstraints()
    }

    func configureView(_ state: DownloadState) {
        switch state {
        case .loading:
            isHidden = true
        case .data:
            isHidden = true
        case .noData:
            isHidden = false
            setupIcon(.search)
            setupTitle(Constants.emptyText)
        case .error:
            isHidden = false
            setupIcon(.bolt)
            setupTitle(Constants.errorText)
        }
    }

    // MARK: - Private Methods

    private func configureUI() {
        for item in [logoImageView, errorTitleLabel, reloadButton] {
            item.translatesAutoresizingMaskIntoConstraints = false
            addSubview(item)
        }
    }

    private func setupIcon(_ image: UIImage) {
        logoImageView.image = image
        logoImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func setupTitle(_ title: String) {
        errorTitleLabel.text = title
        errorTitleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 17).isActive = true
        errorTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        errorTitleLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        errorTitleLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
    }

    private func setupConstraints() {
        reloadButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        reloadButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        reloadButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        reloadButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }

    @objc private func reloadButtonPressed() {
        delegate?.reload()
    }
}
