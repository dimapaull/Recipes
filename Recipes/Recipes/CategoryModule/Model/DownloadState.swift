// DownloadState.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Описывает состояния загрузки данных
enum DownloadState {
    /// Начальное состояние(загрузка не начинается)
    case initial
    /// Процесс загрузки
    case loading
    /// Загрузка прошла успешно
    case success
    /// Загрузка была выполена неуспешно
    case failture
}
