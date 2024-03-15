// FavoritesView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol FavoritesViewProtocol: AnyObject {
    /// Добавление таблицы на основное вью
    func setupTableView()
    /// Удаление таблицы с основного вью
    func removeTableView()
    /// Добавление вью, которая указывает на то, что избранного еще нет
    func setupEmptyView()
    /// Удаление вью, которая указывает на то, что избранного еще нет
    func removeEmptyView()
}

/// Экран избранных рецептов
final class FavoritesView: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let controllerTitle = "Favorities"
        static let controllerRussianTitle = "Избранное"
        static let goToScreenText = "перешел на экран"
        static let emptyTitle = "There's nothing here yet"
        static let emptyContent = "Add interesting recipes to make ordering products convenient"
        static let separateHeight = 5.0
    }

    // MARK: - Visual Components

    private let emptyFavoritesView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let favoriteImageView = {
        let imageView = UIImageView(image: .favoritiesIcon)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let emptyTitleLabel = {
        let label = UILabel()
        label.font = .verdanaBold(ofSize: 18)
        label.text = Constants.emptyTitle
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let emptyContentLabel = {
        let label = UILabel()
        label.font = .verdana(ofSize: 14)
        label.text = Constants.emptyContent
        label.numberOfLines = 2
        label.textColor = .appDarkGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var favoriteTableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CategoryViewCell.self, forCellReuseIdentifier: String(describing: CategoryViewCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Public Properties

    var presenter: FavoritesPresenter?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.favoriteViewWillAppear()
        presenter?.textTitleSection(titleSection: "\(Constants.goToScreenText) \(Constants.controllerRussianTitle)")
    }

    // MARK: - Private Methods

    private func configureNavigationBar() {
        title = Constants.controllerTitle
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupFavoriteImageView() {
        emptyFavoritesView.addSubview(favoriteImageView)
        favoriteImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        favoriteImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        favoriteImageView.centerXAnchor.constraint(equalTo: emptyFavoritesView.centerXAnchor).isActive = true
        favoriteImageView.topAnchor.constraint(equalTo: emptyFavoritesView.topAnchor, constant: 13).isActive = true
    }

    private func setupEmptyTitleLabel() {
        emptyFavoritesView.addSubview(emptyTitleLabel)
        emptyTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        emptyTitleLabel.widthAnchor.constraint(equalTo: emptyFavoritesView.widthAnchor).isActive = true
        emptyTitleLabel.centerXAnchor.constraint(equalTo: emptyFavoritesView.centerXAnchor).isActive = true
        emptyTitleLabel.topAnchor.constraint(equalTo: favoriteImageView.bottomAnchor, constant: 20).isActive = true
    }

    private func setupEmptyContentLabel() {
        emptyFavoritesView.addSubview(emptyContentLabel)
        emptyContentLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emptyContentLabel.widthAnchor.constraint(equalTo: emptyFavoritesView.widthAnchor).isActive = true
        emptyContentLabel.centerXAnchor.constraint(equalTo: emptyFavoritesView.centerXAnchor).isActive = true
        emptyContentLabel.bottomAnchor.constraint(equalTo: emptyFavoritesView.bottomAnchor).isActive = true
    }
}

// MARK: - FavoritesView + UITableViewDataSource

extension FavoritesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        presenter?.favouriteRecipes.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = favoriteTableView
            .dequeueReusableCell(withIdentifier: String(describing: CategoryViewCell.self)) as? CategoryViewCell
        else { return UITableViewCell() }
        // cell.configureCell(info: presenter?.favouriteRecipes[indexPath.section])
        return cell
    }
}

// MARK: - FavoritesView + UITableViewDelegate

extension FavoritesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        Constants.separateHeight
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(
        _ tableView: UITableView,
        editingStyleForRowAt indexPath: IndexPath
    ) -> UITableViewCell.EditingStyle {
        .delete
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath:
        IndexPath
    ) {
        presenter?.favouriteRemoveRecipe(recipe: presenter?.favouriteRecipes[indexPath.section])
        tableView.reloadData()
    }
}

// MARK: - FavoritesView + FavoritesViewProtocol

extension FavoritesView: FavoritesViewProtocol {
    func setupTableView() {
        view.addSubview(favoriteTableView)
        favoriteTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12)
            .isActive = true
        favoriteTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        favoriteTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        favoriteTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }

    func removeTableView() {
        favoriteTableView.removeFromSuperview()
    }

    func setupEmptyView() {
        view.addSubview(emptyFavoritesView)
        emptyFavoritesView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            .isActive = true
        emptyFavoritesView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        emptyFavoritesView.heightAnchor.constraint(equalToConstant: 132).isActive = true
        emptyFavoritesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        emptyFavoritesView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        setupFavoriteImageView()
        setupEmptyTitleLabel()
        setupEmptyContentLabel()
    }

    func removeEmptyView() {
        emptyFavoritesView.removeFromSuperview()
    }
}
