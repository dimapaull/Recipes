// RecipeDetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер для экрана с детальным описанием рецепта
final class RecipeDetailPresenter {
    // MARK: - Private Properties

    private weak var view: RecipeDetailViewProtocol?
    private weak var recipeCoordinator: RecipeCoordinator?
    private var downloadRecipe: DownloadRecipeProtocol?
    private var reseiver: FileManagerServiceProtocol?
    private let networkService: NetworkServiceProtocol?
    private let coreDataService: StorageService?

    // MARK: - Public Properties

    var downloadDetailRecipe: Recipe?
    var state: ViewState<Recipe> = .loading {
        didSet {
            view?.updateState()
        }
    }

    var detailURI: String = ""

    // MARK: - Initializers

    required init(
        view: RecipeDetailViewProtocol,
        recipeCoordinator: RecipeCoordinator,
        downloadRecipe: DownloadRecipeProtocol,
        networkService: NetworkServiceProtocol,
        coreDataService: StorageService
    ) {
        self.view = view
        self.recipeCoordinator = recipeCoordinator
        reseiver = FileManagerService.fileManagerService
        self.downloadRecipe = downloadRecipe
        self.networkService = networkService
        self.coreDataService = coreDataService
    }

    func textTitleSection(titleSection: String) {
        reseiver?.setTitleSection(nameSection: titleSection)
    }

    func addFavouriteRecipe() {
        guard let downloadDetailRecipe = downloadDetailRecipe else { return }
        FavouriteRecipes.shared.updateFavouriteRecipe(downloadDetailRecipe)
        view?.setBookmarkButtonImage()
    }

    func getDetailRecipe(_ completionHandler: (() -> ())? = nil) {
        if let recipe = coreDataService?.fetchRecipeData(uri: detailURI) {
            downloadDetailRecipe = recipe
            state = .data(recipe)
            view?.updateState()
            completionHandler?()
        } else {
            networkService?.getDetailRecipe(uri: detailURI, completionHandler: { [weak self] result in
                switch result {
                case let .success(recipe):
                    self?.downloadDetailRecipe = recipe
                    self?.coreDataService?.createRecipeData(recipes: [recipe], category: nil)
                    DispatchQueue.main.async {
                        self?.state = .data(recipe)
                        self?.view?.updateState()
                    }
                    completionHandler?()
                case let .failure(error):
                    DispatchQueue.main.async {
                        self?.state = .error(error)
                    }
                    completionHandler?()
                }
            })
        }
    }
}
