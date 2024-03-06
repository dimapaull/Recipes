// DownloadView.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol DownloadRecipeProtocol {
    /// Обновляет данные при выполнении загрузки
    var updateCell: ((DownloadState) -> ())? { get set }
    /// Начало загрузки
    func startFetch()
}

/// Загрузка данных из сети
final class DownloadView: DownloadRecipeProtocol {
    var updateCell: ((DownloadState) -> ())?

    init() {
        updateCell?(.initial)
    }

    func startFetch() {
        updateCell?(.loading)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.updateCell?(.success)
        }
    }
}
