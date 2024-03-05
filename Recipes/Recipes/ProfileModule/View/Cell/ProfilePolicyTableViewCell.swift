// ProfilePolicyTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с переходом на вкладку "Политики конфиденциальности"
final class ProfilePolicyTableViewCell: UITableViewCell {
    // MARK: - Constants

    enum Constants {
        static let identifier = "ProfilePolicyTableViewCell"
        static let lightGrayImage = UIImage(named: "lightGrayView")
        static let paperImage = UIImage(named: "paper")
        static let policyText = "Terms & Privacy Policy"
        static let verdanaSize18 = UIFont(name: "Verdana", size: 18)
        static let pointerImage = UIImage(named: "pointer")
    }
    ////////////
    enum CardState {
        case expanded
        case collapsed
    }
    
    var visualEffectView = UIVisualEffectView()
    var cardVisible = false
    var nextState: CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations: [UIViewPropertyAnimator] = []
    var animationProgressWhenInterrupted: CGFloat = 0
    
    func setupCard() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.contentView.frame
        self.contentView.addSubview(visualEffectView)
    }
    ///////////////
    // MARK: - Visual components

    private let lightGrayImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = Constants.lightGrayImage
        return view
    }()

    private let paperImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.paperImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let policyLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.policyText
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

    // MARK: - Private Methods

    private func setupView() {
        contentView.addSubview(lightGrayImageView)
        contentView.addSubview(paperImageView)
        contentView.addSubview(policyLabel)
        contentView.addSubview(pointerImageView)
        contentView.addSubview(lineView)
    }

    private func setupConstraints() {
        setuplightGrayImageViewConstraints()
        setupPaperImageViewConstraints()
        setupPolicyLabelConstraints()
        setupPointerImageViewConstraints()
        setupLineViewConstraints()
    }

    private func setuplightGrayImageViewConstraints() {
        lightGrayImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        lightGrayImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        lightGrayImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        lightGrayImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
    }

    private func setupPaperImageViewConstraints() {
        paperImageView.centerXAnchor.constraint(equalTo: lightGrayImageView.centerXAnchor).isActive = true
        paperImageView.centerYAnchor.constraint(equalTo: lightGrayImageView.centerYAnchor).isActive = true
        paperImageView.heightAnchor.constraint(equalToConstant: 22.17).isActive = true
        paperImageView.widthAnchor.constraint(equalToConstant: 23.34).isActive = true
    }

    private func setupPolicyLabelConstraints() {
        policyLabel.leadingAnchor.constraint(equalTo: lightGrayImageView.trailingAnchor, constant: 16).isActive = true
        policyLabel.centerYAnchor.constraint(equalTo: lightGrayImageView.centerYAnchor).isActive = true
        policyLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        policyLabel.widthAnchor.constraint(equalToConstant: 224).isActive = true
    }

    private func setupPointerImageViewConstraints() {
        pointerImageView.centerYAnchor.constraint(equalTo: paperImageView.centerYAnchor).isActive = true
        pointerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -33.5).isActive = true
        pointerImageView.heightAnchor.constraint(equalToConstant: 14).isActive = true
        pointerImageView.widthAnchor.constraint(equalToConstant: 7).isActive = true
    }

    private func setupLineViewConstraints() {
        lineView.leadingAnchor.constraint(equalTo: lightGrayImageView.trailingAnchor, constant: 16).isActive = true
        lineView.topAnchor.constraint(equalTo: policyLabel.bottomAnchor, constant: 16).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: 249).isActive = true
    }
}
