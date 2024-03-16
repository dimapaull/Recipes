// RecipeDetailView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для управления View
protocol RecipeDetailViewProtocol: AnyObject {
    /// Обновление таблицы
    func reloadTableView()
    /// Установка картинки для кнопки "В избранное"
    func setBookmarkButtonImage()
    /// Обновление состояния View
    func updateState()
}

/// Экран с подробным описанием рецепта
final class RecipeDetailView: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let searchBarPlaceholderText = "Search recipes"
        static let caloriesText = "Calories"
        static let timeText = "Time"
        static let separateHeight = 5.0
        static let zero = 0
        static let one = 1
        static let three = 3
        static let shareButtonImage = UIImage.send
        static let bookmarkButtonImage = UIImage.bookmark
        static let titleAlert = "Функционал в разработке"
        static let okAlert = "Ok"
        static let threeHundredSixty = 360
        static let seventyThree = 73
        static let sevenHundred = 700
        static let bookmarkRedButtonImage = UIImage.favouritesRed
        static let errorText = "Failed to load data"
        static let reloadText = "Reload"
    }

    private enum CellsType {
        /// Фото блюда
        case recipeImage
        /// Информация о пищевой ценности
        case recipeInfo
        /// Подробное описание рецепта
        case recipeDescription
    }

    // MARK: - Visual Components

    private lazy var recipeDetailTableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

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
        label.text = Constants.errorText
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

    private lazy var refreshControll: UIRefreshControl = {
        let refreshControll = UIRefreshControl()
        refreshControll.addTarget(self, action: #selector(swipeTableView), for: .touchUpInside)
        return refreshControll
    }()

    // MARK: - Private Properties

    private let cellsType: [CellsType] = [.recipeImage, .recipeInfo, .recipeDescription]

    // MARK: - Public Properties

    var presenter: RecipeDetailPresenter?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
        tabBarController?.tabBar.isHidden = true
        presenter?.getDetailRecipe()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?
            .textTitleSection(
                titleSection: "Пользователь открыл рецепт под названием \(presenter?.downloadDetailRecipe?.label ?? "")"
            )
    }

    private lazy var bookmarkButtonImage: UIButton = {
        let button = UIButton()
        button.setImage(Constants.bookmarkButtonImage, for: .normal)
        button.addTarget(self, action: #selector(bookmarkButtonImageTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Private Methods

    private func configureNavigationBar() {
        navigationItem.hidesBackButton = true

        let backImage = UIImageView(image: .backButton)
        backImage.contentMode = .scaleAspectFit

        let shareButtonImage = UIImageView(image: Constants.shareButtonImage)
        shareButtonImage.isUserInteractionEnabled = true
        shareButtonImage.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(shareButtonImageTapped))
        )

//        let bookmarkButtonImage = UIImageView(image: Constants.bookmarkButtonImage)
//        bookmarkButtonImage.isUserInteractionEnabled = true
//        bookmarkButtonImage.addGestureRecognizer(
//            UITapGestureRecognizer(target: self, action: #selector(bookmarkButtonImageTapped))
//        )

        let rightStackView = UIStackView(arrangedSubviews: [shareButtonImage, bookmarkButtonImage])
        rightStackView.distribution = .equalSpacing
        rightStackView.spacing = 10
        rightStackView.axis = .horizontal

        navigationItem.leftItemsSupplementBackButton = true

        backImage.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(backBarButtonPressed)
        ))

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backImage)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            customView: rightStackView
        )
    }

    private func setupTableView() {
        recipeDetailTableView.register(
            ShimmerImageViewCell.self,
            forCellReuseIdentifier: ShimmerImageViewCell.identifier
        )
        recipeDetailTableView.register(
            ShimmerCompoundViewCell.self,
            forCellReuseIdentifier: ShimmerCompoundViewCell.identifier
        )
        recipeDetailTableView.register(
            ShimmerDescriptionViewCell.self,
            forCellReuseIdentifier: ShimmerDescriptionViewCell.identifier
        )
        recipeDetailTableView.register(
            RecipeDetailImageCell.self,
            forCellReuseIdentifier: RecipeDetailImageCell.identifier
        )
        recipeDetailTableView.register(
            RecipeDetailCompoundCell.self,
            forCellReuseIdentifier: RecipeDetailCompoundCell.identifier
        )
        recipeDetailTableView.register(
            RecipeDetailDescriptionCell.self,
            forCellReuseIdentifier: RecipeDetailDescriptionCell.identifier
        )
        recipeDetailTableView.rowHeight = UITableView.automaticDimension
    }

    private func addErrorServiceElements() {
        for item in [logoImageView, errorTitleLabel, reloadButton] {
            item.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(item)
        }
        setuplogoImageViewConstraints()
        setupErrorTitleLabelConstraints()
        setupReloadButtonConstraints()
        recipeDetailTableView.removeFromSuperview()
    }

    private func configureUI() {
        view.backgroundColor = .white
        addSubiews()
        setupRecipeTableViewConstraints()
        setupTableView()
    }

    private func addSubiews() {
        recipeDetailTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recipeDetailTableView)
        recipeDetailTableView.addSubview(refreshControll)
    }

    private func setuplogoImageViewConstraints() {
        logoImageView.bottomAnchor.constraint(equalTo: errorTitleLabel.topAnchor, constant: -17).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func setupErrorTitleLabelConstraints() {
        errorTitleLabel.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        errorTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorTitleLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        errorTitleLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
    }

    private func setupReloadButtonConstraints() {
        reloadButton.topAnchor.constraint(equalTo: errorTitleLabel.bottomAnchor, constant: 17).isActive = true
        reloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        reloadButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        reloadButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }

    private func setupRecipeTableViewConstraints() {
        recipeDetailTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        recipeDetailTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        recipeDetailTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        recipeDetailTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func alertBookmarkButton() {
        let alert = UIAlertController(title: Constants.titleAlert, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.okAlert, style: .cancel)
        alert.addAction(okAction)
        present(alert, animated: true)
    }

    @objc private func reloadButtonPressed() {
        presenter?.getDetailRecipe()
    }

    @objc private func swipeTableView() {
        presenter?.getDetailRecipe()
    }

    @objc private func backBarButtonPressed() {
        navigationController?.popViewController(animated: true)
    }

    @objc func bookmarkButtonImageTapped() {
//        alertBookmarkButton()
        presenter?.addFavouriteRecipe()
    }

    @objc func shareButtonImageTapped() {
        presenter?.textTitleSection(titleSection: "поделился рецептом \(presenter?.downloadDetailRecipe?.label ?? "")")
    }
}

// MARK: - CategoryView + UITableViewDataSource, UITableViewDelegate

extension RecipeDetailView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constants.one
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        switch presenter?.state {
        case .loading, .data:
            Constants.three
        case .noData, .error, .none:
            Constants.zero
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = cellsType[indexPath.section]
        switch presenter?.state {
        case .loading:
            recipeDetailTableView.isScrollEnabled = false
            switch cells {
            case .recipeImage:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: ShimmerImageViewCell.identifier,
                    for: indexPath
                ) as? ShimmerImageViewCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                cell.showShimmers()
                return cell
            case .recipeInfo:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: ShimmerCompoundViewCell.identifier,
                    for: indexPath
                ) as? ShimmerCompoundViewCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                cell.showShimmers()
                return cell
            case .recipeDescription:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: ShimmerDescriptionViewCell.identifier,
                    for: indexPath
                ) as? ShimmerDescriptionViewCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                cell.showShimmers()
                return cell
            }
        case .data:
            recipeDetailTableView.isScrollEnabled = true
            switch cells {
            case .recipeImage:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: RecipeDetailImageCell.identifier,
                    for: indexPath
                ) as? RecipeDetailImageCell else {
                    return UITableViewCell()
                }
                cell.configureCell(info: presenter?.downloadDetailRecipe)
                cell.selectionStyle = .none
                return cell
            case .recipeInfo:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: RecipeDetailCompoundCell.identifier,
                    for: indexPath
                ) as? RecipeDetailCompoundCell else {
                    return UITableViewCell()
                }
                cell.configureCell(info: presenter?.downloadDetailRecipe)
                cell.selectionStyle = .none
                return cell
            case .recipeDescription:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: RecipeDetailDescriptionCell.identifier,
                    for: indexPath
                ) as? RecipeDetailDescriptionCell else {
                    return UITableViewCell()
                }
                cell.configureCell(info: presenter?.downloadDetailRecipe)
                return cell
            }
        case .noData, .error, .none:
            break
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cells = cellsType[indexPath.section]
        switch cells {
        case .recipeImage:
            return CGFloat(Constants.threeHundredSixty)
        case .recipeInfo:
            return CGFloat(Constants.seventyThree)
        case .recipeDescription:
            return CGFloat(Constants.threeHundredSixty)
        }
    }
}

// MARK: - RecipeDetailView + RecipeDetailViewProtocol

extension RecipeDetailView: RecipeDetailViewProtocol {
    func reloadTableView() {
        recipeDetailTableView.reloadData()
    }

    func setBookmarkButtonImage() {
        bookmarkButtonImage.setImage(Constants.bookmarkRedButtonImage, for: .normal)
    }

    func updateState() {
        switch presenter?.state {
        case .loading, .data:
            recipeDetailTableView.reloadData()
        case .noData, .error, .none:
            addErrorServiceElements()
        }
    }
}

// MARK: - CategoryView + ErrorViewDelegateProtocol

extension RecipeDetailView: ErrorViewDelegateProtocol {
    func reload() {
//        presenter?.getDishRecipe(recipeSearchBar.text)
    }
}
