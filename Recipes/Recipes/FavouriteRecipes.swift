// FavouriteRecipes.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Любимые рецепты
final class FavouriteRecipes {
    private enum Constants {
        static let recipeKey = "recipeKey"
    }

    static var shared = FavouriteRecipes()

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    private(set) var recipes: [Recipe] = []

    private init() {}

    func updateFavouriteRecipe(_ recipe: Recipe) {
        if recipes.isEmpty {
            recipes.append(recipe)
        } else {
            for (index, value) in recipes.enumerated() where recipe.label == value.label {
                self.recipes.remove(at: index)
                encodeRecipes()
                return
            }
            recipes.append(recipe)
        }
        encodeRecipes()
    }

    private func encodeRecipes() {
        if let encodeRecipes = try? encoder.encode(recipes) {
            UserDefaults.standard.set(encodeRecipes, forKey: Constants.recipeKey)
        }
    }

//    func getRecipes() {
//        if let savedRecipesData = UserDefaults.standard.object(forKey: Constants.recipeKey) as? Data {
//            if let savedRecipes = try? decoder.decode([Recipe].self, from: savedRecipesData) {
//                recipes = savedRecipes
//            }
//        }
//    }
}
