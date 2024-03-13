// CategoryPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер для экрана с категорией рецепта
final class CategoryPresenter {
    // MARK: - Constants

    private enum Constants {
        static let recipeDescription = """
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
        static let minimumCountSymbols = 3
    }

    // MARK: - Private Properties

    private weak var view: CategoryViewProtocol?
    private weak var recipeCoordinator: RecipeCoordinator?
    private var downloadRecipe: DownloadRecipeProtocol?
    private var reseiver: FileManagerServiceProtocol?
    private let categoryName: CategoryRecipeName
    private let networkService: NetworkServiceProtocol?

    // MARK: - Initializers

    init(
        view: CategoryViewProtocol,
        recipeCoordinator: RecipeCoordinator,
        downloadRecipe: DownloadRecipeProtocol,
        categoryName: CategoryRecipeName,
        networkService: NetworkServiceProtocol
    ) {
        self.downloadRecipe = downloadRecipe
        self.recipeCoordinator = recipeCoordinator
        self.view = view
        self.categoryName = categoryName
        self.networkService = networkService
        currentFilterState = .off
        reseiver = FileManagerService.fileManagerService
    }

    // MARK: - Public Properties

    private var searchingNames: [RecipeDetail] = []
    private(set) var currentRecipes: [Recipe] = []
    var downloadRecipes: [Recipe] = []
    var currentFilterState: FilterType {
        willSet {
            currentRecipes = downloadRecipes
            switch newValue {
            case .time:
                currentRecipes.sort { $0.totalTime < $1.totalTime }
            case .calories:
                currentRecipes.sort { $0.calories < $1.calories }
            case .twice:
                currentRecipes.sort {
                    ($0.totalTime + $0.calories) < ($1.totalTime + $1.calories)
                }
            default:
                currentRecipes = downloadRecipes
            }
        }
    }

    func textTitleSection(titleSection: String) {
        reseiver?.setTitleSection(nameSection: titleSection)
    }

    // MARK: - Public Methods

    func selectionRow(in section: Int) {
//        recipeCoordinator?.pushRecipeDetailView(recipe: currentRecipes[section])
//        if let recipeUri = downloadRecipes.first?.uri {
//            networkService?.getDetailRecipe(uri: recipeUri) { result in
//                switch result {
//                case let .success(success):
//                    print(success)
//                case let .failure(failure):
//                    print(failure)
//                }
//            }
//        }
    }

    func filtredRecipes(searchText: String) {
//        if searchText.count < Constants.minimumCountSymbols {
//            currentRecipes = CategoryPresenter.recipes
//        } else {
//            currentRecipes = CategoryPresenter.recipes.filter {
//                $0.title.prefix(searchText.count) == searchText
//            }
//        }
//        view?.reloadTable()
    }

    func getDishRecipe() {
        downloadRecipe?.startFetch()
        networkService?.getDishRecipes(categoryName: categoryName, searchSymbol: nil) { result in
            switch result {
            case let .success(recipes):
                self.currentRecipes = recipes
                self.downloadRecipes = recipes
                DispatchQueue.main.async {
                    self.downloadRecipe?.stopFetch(.data)
                }
                print(recipes)
            case .failure:
                self.downloadRecipe?.stopFetch(.error)
                return
            }
        }

        downloadRecipe?.updateCell = { [weak self] viewData in
            self?.view?.updateCellState = viewData
        }
    }
}

// MARK: - CategoryPresenter + FilterableDelegate

extension CategoryPresenter: FilterableDelegate {
    func choosedFilter(tag: Int, completion: @escaping BoolHandler) {
        switch currentFilterState {
        case .off:
            completion(true)
            if tag == 0 {
                currentFilterState = .calories
            } else {
                currentFilterState = .time
            }
        case .time:
            if tag == 1 {
                currentFilterState = .off
                completion(false)
            } else {
                currentFilterState = .twice
                completion(true)
            }
        case .calories:
            if tag == 0 {
                currentFilterState = .off
                completion(false)
            } else {
                currentFilterState = .twice
                completion(true)
            }
        case .twice:
            completion(false)
            if tag == 0 {
                currentFilterState = .time
            } else {
                currentFilterState = .calories
            }
        }
        view?.reloadTable()
    }
}
