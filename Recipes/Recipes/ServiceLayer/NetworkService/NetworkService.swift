// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Используется для описания сервиса запросов
protocol NetworkServiceProtocol {
    /// Запрос рецептов по категории
    func getDishRecipe(
        categoryName: CategoryRecipeName,
        searchSymbol: String?,
        completionHandler: @escaping (Result<RecipeListDTO?, Error>) -> ()
    )
    /// Запрос рецепта по ссылке
    func getDetailRecipe(
        uri: String,
        completionHandler: @escaping (Result<RecipeListDTO?, Error>) -> ()
    )
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
        static let mainCourseTypeQueryItem = "Main course"
        static let healthTypeQueryItem = "health"
        static let qQueryItem = "q"
    }

    // MARK: - Public Methods

    func getDishRecipe(
        categoryName: CategoryRecipeName, searchSymbol: String? = nil,
        completionHandler: @escaping (Result<RecipeListDTO?, Error>) -> ()
    ) {
        guard let url = createDishRecipeUrlComponent(categoryName, searchSymbol: searchSymbol).url else { return }

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
        guard let url = createDetailRecipeUrlComponent(uri).url else { return }

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

    // MARK: - Private Methods

    private func createDishRecipeUrlComponent(
        _ categoryName: CategoryRecipeName,
        searchSymbol: String?
    ) -> URLComponents {
        var urlComponent = URLComponents()
        urlComponent.scheme = Constants.scheme
        urlComponent.host = Constants.host
        urlComponent.path = Constants.categoryPath
        urlComponent.queryItems = [
            URLQueryItem(name: Constants.typeQueryItem, value: Constants.typeValueQueryItem),
            URLQueryItem(name: Constants.appIdQueryItem, value: Constants.appIdValueQueryItem),
            URLQueryItem(name: Constants.appKeyQueryItem, value: Constants.appKeyValueQueryItem),
        ]
        if categoryName == .chicken || categoryName == .meat || categoryName == .fish || categoryName == .sideDish {
            urlComponent.queryItems?.append(URLQueryItem(
                name: Constants.dishTypeQueryItem,
                value: Constants.mainCourseTypeQueryItem
            ))
        } else {
            urlComponent.queryItems?.append(URLQueryItem(
                name: Constants.dishTypeQueryItem,
                value: categoryName.rawValue
            ))
        }
        if categoryName == .sideDish {
            urlComponent.queryItems?.append(URLQueryItem(
                name: Constants.healthTypeQueryItem,
                value: categoryName.rawValue
            ))
        }
        if categoryName == .chicken || categoryName == .meat || categoryName == .fish {
            urlComponent.queryItems?.append(URLQueryItem(
                name: Constants.qQueryItem,
                value: searchSymbol == nil ? categoryName.rawValue : "\(categoryName.rawValue) \(searchSymbol ?? "")"
            ))
        }
        return urlComponent
    }

    private func createDetailRecipeUrlComponent(_ uri: String) -> URLComponents {
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
        return urlComponent
    }
}
