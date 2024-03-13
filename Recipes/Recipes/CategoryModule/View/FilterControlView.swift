// FilterControlView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol FilterControlViewDataSource {
    /// Нужно вернуть количество ячеек в контроле
    func filterControlCount(_ dayPicker: FilterControlView) -> Int
    /// Нужно вернуть название для кнопки в контроле
    func filterControlTitle(_ dayPicker: FilterControlView, indexPath: IndexPath) -> String
}

protocol FilterableDelegate: AnyObject {
    /// Выбранный фильтр, возвращает обработанное состояние, нажата ли выбранная кнопка, индекс отжатой
    func choosedFilter(tag: Int, completion: @escaping BoolHandler)
}

final class FilterControlView: UIView {
    // MARK: - Visual Components

    private let mainStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private var filterButtons: [AutoAddPaddingButton] = []

    // MARK: - Public Properties

    weak var delagate: FilterableDelegate?
    var dataSource: FilterControlViewDataSource? {
        didSet {
            setupView()
        }
    }

    // MARK: - Private Properties

    private var filterState: FilterType = .off

    // MARK: - Life Cycle

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
            let button = AutoAddPaddingButton()
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

    @objc private func filterButtonPressed(_ sender: AutoAddPaddingButton) {
        delagate?.choosedFilter(
            tag: sender.tag,
            completion: { [weak self] isPressed in
                self?.filterButtons[sender.tag].buttonState = isPressed
            }
        )
    }
}
