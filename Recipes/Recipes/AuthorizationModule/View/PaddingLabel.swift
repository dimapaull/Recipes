// PaddingLabel.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Лейбл с внутреними отступами
final class PaddingLabel: UILabel {
    // MARK: - Private Properties

    private var topInset: CGFloat = 16.0
    private var bottomInset: CGFloat = 17.0
    private var leftInset: CGFloat = 15.0
    private var rightInset: CGFloat = 34.0

    // MARK: - Public Methods

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + leftInset + rightInset,
            height: size.height + topInset + bottomInset
        )
    }
}
