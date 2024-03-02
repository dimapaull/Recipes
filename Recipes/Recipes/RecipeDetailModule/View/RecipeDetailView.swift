// RecipeDetailView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с подробным описанием рецепта
final class RecipeDetailView: UIViewController {
    
    // MARK: - Constants

    private enum Constants {
        static let searchBarPlaceholderText = "Search recipes"
        static let caloriesText = "Calories"
        static let timeText = "Time"
        static let separateHeight = 5.0
    }

    // MARK: - Visual Components

    private let recipeSearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.barStyle = .default
        searchBar.searchTextField.backgroundColor = .appSoftBlue
        searchBar.backgroundImage = nil
        searchBar.backgroundColor = .clear
        searchBar.placeholder = Constants.searchBarPlaceholderText
        return searchBar
    }()

    private lazy var recipeTableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CategoryViewCell.self, forCellReuseIdentifier: String(describing: CategoryViewCell.self))
        return tableView
    }()

    // MARK: - Public Properties

    var presenter: RecipeDetailPresenter?
    var backNavigationTitle = String()

    // MARK: - Private Properties

    private let filterStates = [Constants.caloriesText, Constants.timeText]

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

    private func configureUI() {
        view.backgroundColor = .white
        addSubiews()
        setupRecipeTableViewConstraints()
    }

    private func addSubiews() {
            recipeTableView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(recipeTableView)
    }

    private func setupRecipeTableViewConstraints() {
        recipeTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        recipeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        recipeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            .isActive = true
        recipeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
        presenter?.recipesDetails.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        Constants.separateHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = recipeTableView
            .dequeueReusableCell(withIdentifier: String(describing: CategoryViewCell.self)) as? CategoryViewCell
        else { return UITableViewCell() }
        return cell
    }
}

// MARK: - CategoryView + CategoryViewProtocol

extension RecipeDetailView: CategoryViewProtocol {}

// MARK: - CategoryView + FilterControlViewDataSource

extension RecipeDetailView: FilterControlViewDataSource {
    func filterControlCount(_ dayPicker: FilterControlView) -> Int {
        filterStates.count
    }

    func filterControlTitle(_ dayPicker: FilterControlView, indexPath: IndexPath) -> String {
        filterStates[indexPath.row]
    }
}
