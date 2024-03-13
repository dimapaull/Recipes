// AutoPaddingButton.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кнопка имеющая внутренние отступы
final class AutoAddPaddingButton: UIButton {
    // MARK: - Constants

    private enum Constants {
        static let margin = 24.0
    }

    // MARK: - Public Properties

    override var intrinsicContentSize: CGSize {
        let baseSize = super.intrinsicContentSize
        return CGSize(
            width: baseSize.width + Constants.margin,
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
