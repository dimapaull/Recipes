// CategoryPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер для экрана с категорией рецепта
final class CategoryPresenter {
    // MARK: - Constants

    private enum Constants {
        static let minimumCountSymbols = 3
    }

    // MARK: - Private Properties
    
    private let categoryName: CategoryRecipeName
    private let networkService: NetworkServiceProtocol?
    private var downloadRecipe: DownloadRecipeProtocol?
    private var reseiver: FileManagerServiceProtocol?
    private weak var view: CategoryViewProtocol?
    private weak var recipeCoordinator: RecipeCoordinator?
  

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

    private(set) var currentRecipes: [Recipe] = []
    private var downloadRecipes: [Recipe] = []

    private var currentFilterState: FilterType {
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

    // MARK: - Public Methods

    func textTitleSection(titleSection: String) {
        reseiver?.setTitleSection(nameSection: titleSection)
    }

    func selectionRow(in section: Int) {
        //        if let recipeUri = downloadRecipes.first?.uri {
        //            recipeCoordinator?.pushRecipeDetailView(recipe: recipeUri)
        //        } else {
        //            return
        //        }
        recipeCoordinator?.pushRecipeDetailView(uri: currentRecipes[section].uri)
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
        if searchText.count < Constants.minimumCountSymbols {
            getDishRecipe(nil)
        } else {
            getDishRecipe(searchText)
            //            currentRecipes = CategoryPresenter.recipes.filter {
            //                $0.title.prefix(searchText.count) == searchText
            //            }
        }
        //        view?.reloadTable()
        }
    }

    func getDishRecipe(_ searchText: String?, _ completionHandler: (() -> ())? = nil) {
        downloadRecipe?.startFetch()
        networkService?.getDishRecipes(categoryName: categoryName, searchSymbol: searchText) { result in
            switch result {
            case let .success(recipes):
                self.currentRecipes = recipes
                self.downloadRecipes = recipes
                DispatchQueue.main.async {
                    if recipes.isEmpty {
                        self.downloadRecipe?.stopFetch(.noData)
                    } else {
                        self.downloadRecipe?.stopFetch(.data)
                    }
                }
            case .failure:
                self.downloadRecipe?.stopFetch(.error)
                return
            }
            DispatchQueue.main.async {
                completionHandler?()
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
