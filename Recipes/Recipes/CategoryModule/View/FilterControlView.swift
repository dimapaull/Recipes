// FilterControlView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol FilterControlViewDataSource {
    /// Нужно вернуть количество ячеек в контроле
    func filterControlCount(_ dayPicker: FilterControlView) -> Int
    /// Нужно вернуть название для кнопки в контроле
    func filterControlTitle(_ dayPicker: FilterControlView, indexPath: IndexPath) -> String
}

final class FilterControlView: UIView {
    // MARK: - Types

    enum FilterType {
        /// Отключен
        case off
        /// От большего к меньшему
        case less
        /// От меньшего к большему
        case more
    }

    // MARK: - Visual Components

    private let mainStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private var filterButtons: [AutoAddPaddingButtton] = []

    // MARK: - Public Properties

    var dataSource: FilterControlViewDataSource? {
        didSet {
            setupView()
        }
    }

    // MARK: - Private Properties

    private var filterState: FilterType = .off

    // MARK: - Public Methods

    override func layoutSubviews() {
        super.layoutSubviews()

        mainStackView.frame = bounds
    }

    // MARK: - Private Methods

    private func setupView() {
        guard let countOfItems = dataSource?.filterControlCount(self) else { return }

        for item in 0 ..< countOfItems {
            let indexPath = IndexPath(row: item, section: 0)
            let title = dataSource?.filterControlTitle(self, indexPath: indexPath)
            let button = AutoAddPaddingButtton()
            button.semanticContentAttribute = .forceRightToLeft
            button.layer.cornerRadius = 19
            button.backgroundColor = .appSoftGray
            button.titleLabel?.font = .verdana(ofSize: 16)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.setImage(.stack, for: .normal)
            button.tag = item
            button.addTarget(self, action: #selector(filterButtonPressed), for: .touchUpInside)
            filterButtons.append(button)
            mainStackView.addArrangedSubview(button)
        }
        addSubview(mainStackView)
    }

    @objc private func filterButtonPressed(_ sender: AutoAddPaddingButtton) {
        switch filterState {
        case .off:
            filterButtons[sender.tag].buttonState = true
            if sender.tag == 0 {
                filterState = .more
            } else {
                filterState = .less
            }
        case .less:
            if sender.tag == 1 {
                filterState = .off
                filterButtons[sender.tag].buttonState = false
            } else {
                filterState = .more
                filterButtons[1].buttonState = false
                filterButtons[sender.tag].buttonState = true
            }
        case .more:
            if sender.tag == 0 {
                filterState = .off
                filterButtons[sender.tag].buttonState = false
            } else {
                filterState = .less
                filterButtons[0].buttonState = false
                filterButtons[sender.tag].buttonState = true
            }
        }
    }
}
