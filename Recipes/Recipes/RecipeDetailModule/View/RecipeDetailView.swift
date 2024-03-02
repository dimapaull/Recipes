// RecipeDetailView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol RecipeDetailViewProtocol: AnyObject {}

/// Экран с подробным описанием рецепта
final class RecipeDetailView: UIViewController {
    
    // MARK: - Constants

    private enum Constants {
        static let searchBarPlaceholderText = "Search recipes"
        static let caloriesText = "Calories"
        static let timeText = "Time"
        static let separateHeight = 5.0
    }
    
    enum CellsType {
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

    // MARK: - Public Properties

    var presenter: RecipeDetailPresenter?
    var backNavigationTitle = String()

    // MARK: - Private Properties

    private let cellsType: [CellsType] = [.recipeImage, .recipeInfo, .recipeDescription]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
        tabBarController?.tabBar.isHidden = true
    }

    // MARK: - Private Methods

    private func configureNavigationBar() {
        navigationItem.hidesBackButton = true

        let backImage = UIImageView(image: .backButton)
        backImage.contentMode = .scaleAspectFit

        let backLabel = UILabel()
        backLabel.text = backNavigationTitle
        backLabel.font = .verdanaBold(ofSize: 28)

        let backStackView = UIStackView(arrangedSubviews: [backImage, backLabel])
        backStackView.distribution = .equalSpacing
        backStackView.spacing = 15
        backStackView.axis = .horizontal
        navigationItem.leftItemsSupplementBackButton = true
        backStackView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(backBarButtonPressed)
        ))

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backStackView)
    }
    
    private func setupTableView() {
        recipeDetailTableView.rowHeight = UITableView.automaticDimension
        recipeDetailTableView.register(
            RecipeDetailImageCell.self,
            forCellReuseIdentifier: RecipeDetailImageCell.identifier)
        recipeDetailTableView.register(
            RecipeDetailCompoundCell.self,
            forCellReuseIdentifier: RecipeDetailCompoundCell.identifier)
        recipeDetailTableView.register(
            RecipeDetailDescriptionCell.self,
            forCellReuseIdentifier: RecipeDetailDescriptionCell.identifier)
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
    }

    private func setupRecipeTableViewConstraints() {
        recipeDetailTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        recipeDetailTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        recipeDetailTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            .isActive = true
        recipeDetailTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    @objc private func backBarButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - CategoryView + UITableViewDataSource

extension RecipeDetailView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        Constants.separateHeight
//    }

//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.clear
//        return headerView
//    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = cellsType[indexPath.section]
        switch cells {
        case .recipeImage:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RecipeDetailImageCell.identifier,
                for: indexPath) as? RecipeDetailImageCell else {
                return UITableViewCell()
            }
            return cell
        case .recipeInfo:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RecipeDetailCompoundCell.identifier,
                for: indexPath) as? RecipeDetailCompoundCell else {
                return UITableViewCell()
            }
            return cell
        case .recipeDescription:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RecipeDetailDescriptionCell.identifier,
                for: indexPath) as? RecipeDetailDescriptionCell else {
                return UITableViewCell()
            }
            return cell
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let cells = cellTypes[indexPath.section]
//        switch cells {
//        case .recipeImage:
//            return CGFloat(Constants.twoHundredSeventy)
//        case .recipeInfo:
//            return CGFloat(Constants.seventy)
//        case .recipeDescription:
//            return CGFloat(Constants.seventy)
//    }
}

extension RecipeDetailView: RecipeDetailViewProtocol {}
