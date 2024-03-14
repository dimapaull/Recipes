// DownloadRecipe.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol DownloadRecipeProtocol {
    /// Обновляет данные при выполнении загрузки
    var updateCell: ((DownloadState) -> ())? { get set }
    /// Начало загрузки
    func startFetch()
    /// Остановка загрузки
    func stopFetch(_ downloadState: DownloadState)
}

/// Загрузка данных из сети
final class DownloadRecipe: DownloadRecipeProtocol {
    // MARK: - Public Properties

    var updateCell: ((DownloadState) -> ())?

    // MARK: - Initializers

    init() {
        updateCell?(.loading)
    }

    // MARK: - Public Methods

    func startFetch() {
        updateCell?(.loading)
    }

    func stopFetch(_ downloadState: DownloadState) {
        updateCell?(downloadState)
    }
}
