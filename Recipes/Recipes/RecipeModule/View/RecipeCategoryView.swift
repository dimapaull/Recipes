// RecipeView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с категориями рецептов
final class RecipeCategoryView: UIViewController {

    // MARK: - Constants
    
    private enum Constants {
        static let zero = 0
        static let one = 1
        static let two = 2
        static let three = 3
        static let seven = 7
        static let ten = 10
        static let forty = 40
        static let eighty = 80
        
        static let defaultAssertText = "Unexpected element kind"
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
    
    let recipes: [RecipeCategory] = [
        RecipeCategory(recipeCategoryImage: "salad", recipeCategoryTitle: "Salad"),
        RecipeCategory(recipeCategoryImage: "soup", recipeCategoryTitle: "Soup"),
        RecipeCategory(recipeCategoryImage: "chicken", recipeCategoryTitle: "Chicken"),
        RecipeCategory(recipeCategoryImage: "meat", recipeCategoryTitle: "Meat"),
        RecipeCategory(recipeCategoryImage: "fish", recipeCategoryTitle: "Fish"),
        RecipeCategory(recipeCategoryImage: "sidedish", recipeCategoryTitle: "Side dish"),
        RecipeCategory(recipeCategoryImage: "drinks", recipeCategoryTitle: "Drinks"),
        RecipeCategory(recipeCategoryImage: "pancakes", recipeCategoryTitle: "Pancake"),
        RecipeCategory(recipeCategoryImage: "desserts", recipeCategoryTitle: "Desserts")
    ]

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
    }

    // MARK: - Public Methods

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
            withReuseIdentifier: HeaderRecipeCategoryViewCell.headerReuseidentifier)
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

/// RecipeCategoryView + UICollectionViewDataSource
extension RecipeCategoryView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Constants.one
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recipes.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecipeCategoryViewCell.identifier,
            for: indexPath) as? RecipeCategoryViewCell else { return UICollectionViewCell() }
        cell.configureCell(info: recipes[indexPath.row])
        return cell
    }
}

/// RecipeCategoryView + UICollectionViewDelegate
extension RecipeCategoryView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let titleCategory = recipes[indexPath.row].recipeCategoryTitle
        presenter?.chooseRecipe(title: titleCategory)
    }
}

/// RecipeCategoryView + UICollectionViewDelegateFlowLayout
 extension RecipeCategoryView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellSize = CGFloat()
            let cellNumber = indexPath.item % Constants.seven
        
        switch cellNumber {
        case 0, 1:
            cellSize = (view.frame.width - 30) / 2
        case 2, 6:
            cellSize = view.frame.width * 240 / 380
        case 3...5:
            cellSize = (view.frame.width - 40) / 3
        default:
            cellSize = CGFloat(Constants.ten)
        }
        return CGSize(width: cellSize, height: cellSize)
    }
     
     func collectionView(_ collectionView: UICollectionView,
                         viewForSupplementaryElementOfKind kind: String,
                         at indexPath: IndexPath) -> UICollectionReusableView {
         
         switch kind {
         case UICollectionView.elementKindSectionHeader:
             guard let headerCell = collectionView.dequeueReusableSupplementaryView(
                 ofKind: kind,
                 withReuseIdentifier: HeaderRecipeCategoryViewCell.headerReuseidentifier,
                 for: indexPath) as? HeaderRecipeCategoryViewCell else { return UICollectionViewCell() }
             return headerCell
         case UICollectionView.elementKindSectionFooter:
             guard let footerCell = collectionView.dequeueReusableSupplementaryView(
                 ofKind: kind,
                 withReuseIdentifier: FooterRecipeCategoryViewCell.footerReuseidentifier,
                 for: indexPath) as? FooterRecipeCategoryViewCell else { return UICollectionViewCell() }
             return footerCell
         default:
             assert(false, Constants.defaultAssertText)
         }
     }
     
     func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
     ) -> CGSize {
         return CGSize(width: Constants.zero, height: Constants.eighty)
     }
     
     func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForFooterInSection section: Int
     ) -> CGSize {
         return CGSize(width: Constants.zero, height: Constants.forty)
     }
 }
