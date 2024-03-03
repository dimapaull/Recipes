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
        static let one = 1
        static let three = 3
        static let shareButtonImage = UIImage(named: "send")
        static let bookmarkButtonImage = UIImage(named: "bookmark")
        static let titleAlert = "Функционал в разработке"
        static let okAlert = "Ok"
        static let threeHundredSixty = 360
        static let seventyThree = 73
        static let sevenHundred = 700
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
    
    // MARK: - Private Properties

    private let cellsType: [CellsType] = [.recipeImage, .recipeInfo, .recipeDescription]

    // MARK: - Public Properties

    var presenter: RecipeDetailPresenter?
    var backNavigationTitle = String()
    var recipesDetails = RecipeDetail(
        title: "Simple Fish And Corn",
        imageName: "eat",
        dishWeight: "793",
        cookingTime: "60",
        kilocalories: "1322",
        carbohydrates: "10,78",
        fats: "10,00",
        proteins: "97,30",
        description: """
1/2 to 2 fish heads, depending on size, about 5 pounds total
2 tablespoons vegetable oil
1/4 cup red or green thai curry paste
3 tablespoons fish sauce or anchovy sauce
1 tablespoon sugar
1 can coconut milk, about 12 ounces
3 medium size asian eggplants, cut int 1 inch
rounds
Handful of bird's eye chilies
1/2 cup thai basil leaves
Juice of 3 limes
1/2 to 2 fish heads, depending on size, about 5 pounds total
2 tablespoons vegetable oil
1/4 cup red or green thai curry paste
3 tablespoons fish sauce or anchovy sauce
1 tablespoon sugar
1 can coconut milk, about 12 ounces
3 medium size asian eggplants, cut int 1 inch
rounds
Handful of bird's eye chilies
1/2 cup thai basil leaves
Juice of 3 limes
1/2 to 2 fish heads, depending on size, about 5 pounds total
2 tablespoons vegetable oil
1/4 cup red or green thai curry paste
3 tablespoons fish sauce or anchovy sauce
1 tablespoon sugar
1 can coconut milk, about 12 ounces
3 medium size asian eggplants, cut int 1 inch
rounds
Handful of bird's eye chilies
1/2 cup thai basil leaves
Juice of 3 limes
"""
    )

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
        
        let shareButtonImage = UIImageView(image: Constants.shareButtonImage)
        let bookmarkButtonImage = UIImageView(image: Constants.bookmarkButtonImage)
        bookmarkButtonImage.isUserInteractionEnabled = true
        bookmarkButtonImage.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(bookmarkButtonImageTapped))
        )
        
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
            customView: rightStackView)
    }
    
    private func setupTableView() {
        recipeDetailTableView.register(
            RecipeDetailImageCell.self,
            forCellReuseIdentifier: RecipeDetailImageCell.identifier)
        recipeDetailTableView.register(
            RecipeDetailCompoundCell.self,
            forCellReuseIdentifier: RecipeDetailCompoundCell.identifier)
        recipeDetailTableView.register(
            RecipeDetailDescriptionCell.self,
            forCellReuseIdentifier: RecipeDetailDescriptionCell.identifier)
        recipeDetailTableView.rowHeight = UITableView.automaticDimension
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

    @objc private func backBarButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func bookmarkButtonImageTapped() {
        alertBookmarkButton()
    }
}

// MARK: - CategoryView + UITableViewDataSource

extension RecipeDetailView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constants.one
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Constants.three
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = cellsType[indexPath.section]
        switch cells {
        case .recipeImage:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RecipeDetailImageCell.identifier,
                for: indexPath) as? RecipeDetailImageCell else {
                return UITableViewCell()
            }
            cell.configureCell(info: recipesDetails)
            cell.selectionStyle = .none
            return cell
        case .recipeInfo:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RecipeDetailCompoundCell.identifier,
                for: indexPath) as? RecipeDetailCompoundCell else {
                return UITableViewCell()
            }
            cell.configureCell(info: recipesDetails)
            cell.selectionStyle = .none
            return cell
        case .recipeDescription:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RecipeDetailDescriptionCell.identifier,
                for: indexPath) as? RecipeDetailDescriptionCell else {
                return UITableViewCell()
            }
            cell.configureCell(info: recipesDetails)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cells = cellsType[indexPath.section]
        switch cells {
        case .recipeImage:
            return CGFloat(Constants.threeHundredSixty)
        case .recipeInfo:
            return CGFloat(Constants.seventyThree)
        case .recipeDescription:
            return CGFloat(Constants.sevenHundred)
        }
    }
}

extension RecipeDetailView: RecipeDetailViewProtocol {}
