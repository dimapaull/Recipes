// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Выбор категории рецептов
enum CategoryRecipeName: String {
    case salad = "Salad"
    case soup = "Soup"
    case mainCourse = "Main course"
    case pancake = "Pancake"
    case drinks = "Drinks"
    case desserts = "Desserts"
}

/// Используется для описания сервиса запросов
protocol NetworkServiceProtocol {
    /// Запрос рецептов по категории
    func getDishRecipe(
        categoryName: CategoryRecipeName,
        completionHandler: @escaping (Result<RecipeListDTO?, Error>) -> ()
    )
    /// Запрос рецепта по ссылке
    func getDetailRecipe(uri: String, completionHandler: @escaping (Result<RecipeListDTO?, Error>) -> ())
}

/// Сервис для работы с сетью, запрашивает данные о рецептах
final class NetworkService: NetworkServiceProtocol {
    // MARK: - Constants

    private enum Constants {
        static let scheme = "https"
        static let host = "api.edamam.com"
        static let categoryPath = "/api/recipes/v2"
        static let detailPath = "/api/recipes/v2/by-uri"
        static let typeQueryItem = "type"
        static let typeValueQueryItem = "public"
        static let appIdQueryItem = "app_id"
        static let appIdValueQueryItem = "df3b8de1"
        static let appKeyQueryItem = "app_key"
        static let appKeyValueQueryItem = "eaf7a9b6dd78df72532332124fb0b972"
        static let uriQueryItem = "uri"
        static let dishTypeQueryItem = "dishType"
    }

    // MARK: - Public Methods

    func getDishRecipe(
        categoryName: CategoryRecipeName,
        completionHandler: @escaping (Result<RecipeListDTO?, Error>) -> ()
    ) {
        var urlComponent = URLComponents()
        urlComponent.scheme = Constants.scheme
        urlComponent.host = Constants.host
        urlComponent.path = Constants.categoryPath
        urlComponent.queryItems = [
            URLQueryItem(name: Constants.typeQueryItem, value: Constants.typeValueQueryItem),
            URLQueryItem(name: Constants.appIdQueryItem, value: Constants.appIdValueQueryItem),
            URLQueryItem(name: Constants.appKeyQueryItem, value: Constants.appKeyValueQueryItem),
            URLQueryItem(
                name: Constants.dishTypeQueryItem,
                value: categoryName.rawValue
            ),
        ]

        guard let url = urlComponent.url else { return }

        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            } else if let data = data {
                do {
                    let obj = try JSONDecoder().decode(RecipeListDTO.self, from: data)
                    completionHandler(.success(obj))
                } catch {
                    completionHandler(.failure(error))
                }
            }
        }.resume()
    }

    func getDetailRecipe(uri: String, completionHandler: @escaping (Result<RecipeListDTO?, Error>) -> ()) {
        var urlComponent = URLComponents()
        urlComponent.scheme = Constants.scheme
        urlComponent.host = Constants.host
        urlComponent.path = Constants.detailPath
        urlComponent.queryItems = [
            URLQueryItem(name: Constants.typeQueryItem, value: Constants.typeValueQueryItem),
            URLQueryItem(name: Constants.appIdQueryItem, value: Constants.appIdValueQueryItem),
            URLQueryItem(name: Constants.appKeyQueryItem, value: Constants.appKeyValueQueryItem),
            URLQueryItem(
                name: Constants.uriQueryItem,
                value: uri
            ),
        ]
        print(urlComponent)
        guard let url = urlComponent.url else { return }

        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            } else if let data = data {
                do {
                    let obj = try JSONDecoder().decode(RecipeListDTO.self, from: data)
                    completionHandler(.success(obj))
                } catch {
                    completionHandler(.failure(error))
                }
            }
        }.resume()
    }
}
