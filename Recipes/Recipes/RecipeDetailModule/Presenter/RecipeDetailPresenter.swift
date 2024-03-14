// RecipeDetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер для экрана с детальным описанием рецепта
final class RecipeDetailPresenter {
    // MARK: - Private Properties

    private weak var view: RecipeDetailViewProtocol?
    private weak var recipeCoordinator: RecipeCoordinator?
    private var reseiver: FileManagerServiceProtocol?
    private var downloadRecipe: DownloadRecipeProtocol?
    private let networkService: NetworkServiceProtocol?

    // MARK: - Public Properties

//    var recipeDetailInfo: RecipeDetail?
    var downloadDetailRecipe: RecipeDetailTest?

    // MARK: - Initializers

    required init(
        view: RecipeDetailViewProtocol,
        recipeCoordinator: RecipeCoordinator,
        networkService: NetworkServiceProtocol
    ) {
        self.view = view
        self.recipeCoordinator = recipeCoordinator
        reseiver = FileManagerService.fileManagerService
        self.networkService = networkService
    }

    func textTitleSection(titleSection: String) {
        reseiver?.setTitleSection(nameSection: titleSection)
    }

    func addFavouriteRecipe() {
//        guard let recipeDetailInfo = recipeDetailInfo else { return }
//        FavouriteRecipes.shared.updateFavouriteRecipe(recipeDetailInfo)
    }

    func getDetailRecipe() {
        let recipeUri = "http://www.edamam.com/ontologies/edamam.owl#recipe_e074fb5e814ed30309780398e68c2b90"
        networkService?.getDetailRecipe(uri: recipeUri, completionHandler: { result in
            switch result {
            case let .success(success):
                DispatchQueue.main.async {
                    self.downloadDetailRecipe = success
                    self.view?.reloadTableView()
                    print(success)
                }
            case let .failure(failure):
                print(failure)
            }
        })
    }
}
