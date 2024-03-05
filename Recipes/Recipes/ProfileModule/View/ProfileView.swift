// ProfileView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol ProfileViewProtocol: AnyObject {}

protocol ChangebleTitleProtocol: AnyObject {
    func changeTitleFullName(title: String)
}

/// Экран профиля пользователя
final class ProfileView: UIViewController {
    // MARK: - Constants
    
    private enum Constants {
        static let alertTitle = "Are you sure you want to log out?"
        static let yesAlert = "Yes"
        static let cancelAlert = "Cancel"
        static let okAlert = "Ok"
        static let titleAlert = "Change your name and surname"
        static let placeholderText = "Name Surname"
        static let twoHundredSeventy = 270
        static let seventy = 70
        static let one = 1
        static let four = 4
    }
    
    private enum CellTypes {
        /// Ячейка с аватаром профиля
        case profileAvatar
        /// Ячейка с разделом "Бонусы"
        case profileBonuses
        /// Ячейка с политикой конфиденциальности
        case profilePolicy
        /// Ячейка с выходом из профиля
        case profileLogOut
    }
    
    // MARK: - Visual Components
    
    private let tableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Public Properties
    
    var presenter: ProfilePresenter?
    
    // MARK: - Private Properties
    
    private let cellTypes: [CellTypes] = [.profileAvatar, .profileBonuses, .profilePolicy, .profileLogOut]
    
    private enum CardState {
        case expanded
        case collapsed
        case closed
    }
    
    private let cardHeight: CGFloat = 600
    private let cardHandleAreaHeight: CGFloat = 265
    private var cardViewController: PolicyView!
    private var visualEffectView: UIVisualEffectView!
    private var cardVisible = false
    private var nextState: CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    private var runningAnimations: [UIViewPropertyAnimator] = []
    private var animationProgressWhenInterrupted: CGFloat = 0
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureUI()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Profile"
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
    
    private func setupCard() {
        tabBarController?.tabBar.isHidden = true
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        
        cardViewController = PolicyView()
        cardViewController.delegate = self
        
        self.addChild(cardViewController)
        self.view.addSubview(cardViewController.view)
        
        cardViewController.view.frame = CGRect(
            x: 0,
            y: self.view.frame.height - cardHandleAreaHeight,
            width: self.view.bounds.width,
            height: cardHeight)
        
        cardViewController.view.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(handleCardTap(recognzier:)))
        let panGestureRecognizer = UIPanGestureRecognizer(
            target: self,
            action: #selector(handleCardPan(recognizer:)))
        
        cardViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc private func handleCardTap(recognzier: UITapGestureRecognizer) {
        switch recognzier.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
    
    @objc private func handleCardPan (recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: self.cardViewController.handleArea)
            var fractionComplete = translation.y / cardHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    private func animateTransitionIfNeeded (state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                case .collapsed:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
                case .closed:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight + 900
                    self.visualEffectView.removeFromSuperview()
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded:
                    self.cardViewController.view.layer.cornerRadius = 12
                case .collapsed:
                    self.cardViewController.view.layer.cornerRadius = 0
                case .closed:
                    break
                }
            }
            
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
                case .collapsed:
                    self.visualEffectView.effect = nil
                case .closed:
                    break
                }
            }
            
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
            
        }
    }
    
    private func startInteractiveTransition(state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    private func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    private func continueInteractiveTransition () {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
}

// MARK: - ProfileView + UITableViewDataSource, UITableViewDelegate

extension ProfileView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constants.one
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        Constants.four
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = cellTypes[indexPath.section]
        switch cells {
        case .profileAvatar:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileAvatarTableViewCell.Constants.identifier,
                for: indexPath
            )
                as? ProfileAvatarTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.delegate = self
            presenter?.cellDelegate = cell
            return cell
        case .profileBonuses:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileBonusesTableViewCell.Constants.identifier,
                for: indexPath
            )
                as? ProfileBonusesTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        case .profilePolicy:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfilePolicyTableViewCell.Constants.identifier,
                for: indexPath
            )
                as? ProfilePolicyTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        case .profileLogOut:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: LogOutTableViewCell.Constants.identifier,
                for: indexPath
            )
                as? LogOutTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cells = cellTypes[indexPath.section]
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
            setupCard()
        case .profileLogOut:
            logOutAlert()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cells = cellTypes[indexPath.section]
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

extension ProfileView: ProfileViewProtocol {}

extension ProfileView: RemovableControllerProtocol {
    func removeController() {
        animateTransitionIfNeeded(state: .closed, duration: 1.0)
    }
}
