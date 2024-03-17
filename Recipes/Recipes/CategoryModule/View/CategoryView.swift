// CategoryView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Нужен для управления вью
protocol CategoryViewProtocol: AnyObject {
    /// Принимает состояние процесса скачивания рецепта
    var updateCellState: DownloadState { get set }
    /// Обновляет данные в таблице
    func reloadTable()
}

/// Экран выбора категории
final class CategoryView: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let searchBarPlaceholderText = "Search recipes"
        static let caloriesText = "Calories"
        static let timeText = "Time"
        static let separateHeight = 5.0
        static let titleSection = "перешел на экран со списком рецептов из "
    }

    // MARK: - Visual Components

    private lazy var reloadControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadControlUsed), for: .valueChanged)
        return refreshControl
    }()

    private lazy var recipeSearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.barStyle = .default
        searchBar.searchTextField.backgroundColor = .appSoftBlue
        searchBar.backgroundImage = nil
        searchBar.backgroundColor = .clear
        searchBar.delegate = self
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.placeholder = Constants.searchBarPlaceholderText
        return searchBar
    }()

    private lazy var filterControlView = {
        let controlView = FilterControlView()
        controlView.dataSource = self
        controlView.delegate = presenter
        return controlView
    }()

    private lazy var recipeTableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CategoryViewCell.self, forCellReuseIdentifier: String(describing: CategoryViewCell.self))
        tableView.refreshControl = reloadControl
        return tableView
    }()

    private lazy var errorView = {
        let view = ErrorView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Public Properties

    var presenter: CategoryPresenter?
    var backNavigationTitle = String()
    var updateCellState: DownloadState = .loading {
        didSet {
            DispatchQueue.main.async {
                self.errorView.configureView(self.updateCellState)
                self.recipeTableView.reloadData()
            }
        }
    }

    // MARK: - Private Properties

    private let filterStates = [Constants.caloriesText, Constants.timeText]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        configureUI()
        configureNavigationBar()
        presenter?.getDishRecipe(nil)
        errorView.configureView(updateCellState)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.textTitleSection(titleSection: Constants.titleSection + backNavigationTitle)
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
        setupSearchBarConstraints()
        setupFilterControlViewConstraints()
        setupRecipeTableViewConstraints()
        addErrorView()
    }

    private func addErrorView() {
        view.addSubview(errorView)
        errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        errorView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    private func addSubiews() {
        for item in [recipeSearchBar, filterControlView, recipeTableView] {
            item.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(item)
        }
    }

    private func setupSearchBarConstraints() {
        recipeSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        recipeSearchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        recipeSearchBar.heightAnchor.constraint(equalToConstant: 36).isActive = true
        recipeSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        recipeSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }

    private func setupFilterControlViewConstraints() {
        filterControlView.topAnchor.constraint(equalTo: recipeSearchBar.bottomAnchor, constant: 20).isActive = true
        filterControlView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        filterControlView.widthAnchor.constraint(equalToConstant: 190).isActive = true
        filterControlView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }

    private func setupRecipeTableViewConstraints() {
        recipeTableView.topAnchor.constraint(equalTo: filterControlView.bottomAnchor, constant: 10).isActive = true
        recipeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        recipeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            .isActive = true
        recipeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    @objc private func backBarButtonPressed() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func reloadControlUsed() {
        presenter?.getDishRecipe(recipeSearchBar.text) {
            self.reloadControl.endRefreshing()
        }
    }
}

// MARK: - CategoryView + UITableViewDataSource

extension CategoryView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        updateCellState == .loading ? 10 : presenter?.currentRecipes.count ?? 0
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
        if updateCellState != .loading {
            cell.configureCell(info: presenter?.currentRecipes[indexPath.section])
        }
        switch updateCellState {
        case .loading:
            recipeTableView.isHidden = false
            recipeTableView.isScrollEnabled = false
            cell.showShimmers()
        case .data:
            recipeTableView.isHidden = false
            recipeTableView.isScrollEnabled = true
            cell.removeShimmers()
        case .noData:
            recipeTableView.isHidden = true
        case .error:
            recipeTableView.isHidden = true
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectionRow(in: indexPath.section)
    }
}

// MARK: - CategoryView + CategoryViewProtocol

extension CategoryView: CategoryViewProtocol {
    func reloadTable() {
        recipeTableView.reloadData()
    }
}

// MARK: - CategoryView + FilterControlViewDataSource

extension CategoryView: FilterControlViewDataSource {
    func filterControlCount(_ dayPicker: FilterControlView) -> Int {
        filterStates.count
    }

    func filterControlTitle(_ dayPicker: FilterControlView, indexPath: IndexPath) -> String {
        filterStates[indexPath.row]
    }
}

// MARK: - CategoryView + UISearchBarDelegate

extension CategoryView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.filtredRecipes(searchText: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

// MARK: - CategoryView + ErrorViewDelegateProtocol

extension CategoryView: ErrorViewDelegateProtocol {
    func reload() {
        presenter?.getDishRecipe(recipeSearchBar.text)
    }
}
