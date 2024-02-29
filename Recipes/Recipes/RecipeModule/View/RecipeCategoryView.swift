// RecipeView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с категориями рецептов
final class RecipeCategoryView: UIViewController {
    // MARK: - Types

    // MARK: - Constants

    // MARK: - Visual Components
    
    private let recipeCollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    // MARK: - Public Properties

    var presenter: RecipePresenter?

    // MARK: - Private Properties
    
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

    // MARK: - Initializers

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupRecipeCollectionView()
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

extension RecipeCategoryView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        9
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

extension RecipeCategoryView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = indexPath.row
        presenter.
    }
}

 extension RecipeCategoryView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellSize = CGFloat()
        let cellNumber = indexPath.item % 7
        
        switch cellNumber {
        case 0, 1:
            cellSize = (view.frame.width - 30) / 2
        case 2, 6:
            cellSize = view.frame.width * 240 / 380
        case 3...5:
            cellSize = (view.frame.width - 40) / 3
        default:
            cellSize = 10
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
             assert(false, "Unexpected element kind")
         }
     }
     
     func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
     ) -> CGSize {
         return CGSize(width: 0, height: 80)
     }
     
     func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForFooterInSection section: Int
     ) -> CGSize {
         return CGSize(width: 0, height: 40)
     }
 }
