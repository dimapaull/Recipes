// AutoPaddingButton.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кнопка имеющая внутрение отступы
final class AutoAddPaddingButtton: UIButton {
    // MARK: - Public Properties

    override var intrinsicContentSize: CGSize {
        let baseSize = super.intrinsicContentSize
        return CGSize(
            width: baseSize.width + 24,
            height: baseSize.height
        )
    }

    var buttonState: Bool {
        didSet {
            if buttonState {
                backgroundColor = .appLightBlue
            } else {
                backgroundColor = .appLightGray
            }
        }
    }

    // MARK: - Private Properties

    // MARK: - Initializers

    required init(buttonState: Bool = false) {
        self.buttonState = buttonState
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        buttonState = false
        super.init(frame: .zero)
    }
}
