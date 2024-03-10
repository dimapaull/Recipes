// RecipeCategoryView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol RecipeCategoryViewProtocol: AnyObject {}

/// Экран с категориями рецептов
final class RecipeCategoryView: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let zero = 0
        static let one = 1
        static let two = 2.0
        static let three = 3.0
        static let seven = 7
        static let ten = 10
        static let thirty = 30.0
        static let forty = 40.0
        static let fortyInt = 40
        static let eighty = 80
        static let case2 = 240.0 / 380.0
        static let defaultAssertText = "Unexpected element kind"
        static let titleSection = "открыл экран Рецептов"
    }

    // MARK: - Visual Components

    private let recipeCollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    // MARK: - Public Properties

    var presenter: RecipePresenter?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupRecipeCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        presenter?.textTitleSection(titleSection: Constants.titleSection)
    }

    // MARK: - Private Methods

    private func setupRecipeCollectionView() {
        recipeCollectionView.dataSource = self
        recipeCollectionView.delegate = self
        recipeCollectionView.register(
            RecipeCategoryViewCell.self,
            forCellWithReuseIdentifier: RecipeCategoryViewCell.identifier
        )
        recipeCollectionView.register(
            HeaderRecipeCategoryViewCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderRecipeCategoryViewCell.headerReuseidentifier
        )
        recipeCollectionView.register(
            FooterRecipeCategoryViewCell.self,
            forSupplementaryViewOfKind:
            UICollectionView.elementKindSectionFooter,
            withReuseIdentifier:
            FooterRecipeCategoryViewCell.footerReuseidentifier
        )
    }

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(recipeCollectionView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            recipeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 9),
            recipeCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            recipeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -9),
            recipeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - RecipeCategoryView + UICollectionViewDataSource

extension RecipeCategoryView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Constants.one
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.recipes.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecipeCategoryViewCell.identifier,
            for: indexPath
        ) as? RecipeCategoryViewCell else { return UICollectionViewCell() }
        cell.configureCell(info: presenter?.recipes[indexPath.row])
        return cell
    }
}

// MARK: - RecipeCategoryView + UICollectionViewDelegate

extension RecipeCategoryView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let titleCategory = presenter?.recipes[indexPath.row].recipeCategoryTitle else { return }
        presenter?.chooseRecipe(title: titleCategory)
    }
}

// MARK: - RecipeCategoryView + UICollectionViewDelegateFlowLayout

extension RecipeCategoryView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        var cellSize = CGFloat()
        let cellNumber = indexPath.item % Constants.seven

        switch cellNumber {
        case 0, 1:
            cellSize = (view.frame.width - Constants.thirty) / Constants.two
        case 2, 6:
            cellSize = view.frame.width * Constants.case2
        case 3 ... 5:
            cellSize = (view.frame.width - Constants.forty) / Constants.three
        default:
            cellSize = CGFloat(Constants.ten)
        }
        return CGSize(width: cellSize, height: cellSize)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerCell = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderRecipeCategoryViewCell.headerReuseidentifier,
                for: indexPath
            ) as? HeaderRecipeCategoryViewCell else { return UICollectionViewCell() }
            return headerCell
        case UICollectionView.elementKindSectionFooter:
            guard let footerCell = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: FooterRecipeCategoryViewCell.footerReuseidentifier,
                for: indexPath
            ) as? FooterRecipeCategoryViewCell else { return UICollectionViewCell() }
            return footerCell
        default:
            assertionFailure(Constants.defaultAssertText)
        }
        return UICollectionReusableView()
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        CGSize(width: Constants.zero, height: Constants.eighty)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForFooterInSection section: Int
    ) -> CGSize {
        CGSize(width: Constants.zero, height: Constants.fortyInt)
    }
}

extension RecipeCategoryView: RecipeCategoryViewProtocol {}
