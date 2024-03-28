// StorageService.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

/// Сервис для управления данными coreData
final class StorageService {
    // MARK: - Constants

    enum Constants {
        static let recipeData = "RecipeData"
        static let detailRecipeData = "DetailRecipeData"
        static let coreData = "CoreData"
    }

    // MARK: - Private properties

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.coreData)
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                print(error.localizedDescription)
            }
        })
        return container
    }()

    private var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    // MARK: - Public methods

    func createRecipeData(recipes: [Recipe], category: CategoryRecipeName?) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: Constants.recipeData, in: context)
        else { return }
        for recipe in recipes {
            let recipeData = RecipeData(entity: entityDescription, insertInto: context)
            recipeData.category = category?.rawValue ?? ""
            recipeData.uri = recipe.uri
            recipeData.label = recipe.label
            recipeData.image = recipe.image
            recipeData.calories = recipe.calories
            recipeData.totalTime = recipe.totalTime
            recipeData.totalWeight = recipe.totalWeight
            recipeData.energyCalories = recipe.energyCalories
            recipeData.carb = recipe.carb
            recipeData.fat = recipe.fat
            recipeData.protein = recipe.protein
            recipeData.ingredientLines = recipe.ingredientLines
        }
        saveContext()
    }

    func fetchRecipeData(uri: String) -> Recipe? {
        do {
            guard let result = try? context.fetch(RecipeData.fetchRequest()) else { return nil }
            guard let recipe = result.first(where: { $0.uri == uri }) else { return nil }
            return Recipe(cdRecipe: recipe)
        }
    }

    func fetchRecipeData(category: CategoryRecipeName) -> [Recipe] {
        do {
            guard let result = try? context.fetch(RecipeData.fetchRequest()) else { return [] }
            let filteredRecipes = result.filter { $0.category == category.rawValue }.map { item in
                Recipe(cdRecipe: item)
            }
            return filteredRecipes
        }
    }

    // MARK: - Private Methods

    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                print(error.localizedDescription)
            }
        }
    }
}
