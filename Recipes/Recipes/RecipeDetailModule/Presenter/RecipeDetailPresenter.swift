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

    // MARK: - Public Properties

    var downloadDetailRecipe: RecipeDetailTest?
    var state: ViewState<RecipeDetailTest> = .loading {
        didSet {
            view?.updateState()
        }
    }

    // MARK: - Initializers

    required init(
        view: RecipeDetailViewProtocol,
        recipeCoordinator: RecipeCoordinator,
        downloadRecipe: DownloadRecipeProtocol,
        networkService: NetworkServiceProtocol
    ) {
        self.view = view
        self.recipeCoordinator = recipeCoordinator
        reseiver = FileManagerService.fileManagerService
        self.downloadRecipe = downloadRecipe
        self.networkService = networkService
    }

    func textTitleSection(titleSection: String) {
        reseiver?.setTitleSection(nameSection: titleSection)
    }

    func addFavouriteRecipe() {
        guard let downloadDetailRecipe = downloadDetailRecipe else { return }
        FavouriteRecipes.shared.updateFavouriteRecipe(downloadDetailRecipe)
        view?.setBookmarkButtonImage()
    }

    func getDetailRecipe() {
        let recipeUri = "http://www.edamam.com/ontologies/edamam.owl#recipe_e074fb5e814ed30309780398e68c2b90"
        networkService?.getDetailRecipe(uri: recipeUri, completionHandler: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(recipeDetailTest):
                    self?.downloadDetailRecipe = recipeDetailTest
                    self?.state = .data(recipeDetailTest)
                    self?.view?.updateState()
                case let .failure(error):
                    self?.state = .error(error)
                }
            }
        })
    }
}
