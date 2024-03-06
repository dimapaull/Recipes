// DownloadState.swift
// Copyright © RoadMap. All rights reserved.

/// Описывает состояния загрузки данных
enum DownloadState {
    /// Начальное состояние(загрузка только начинается)
    case initial
    /// Процесс загрузки
    case loading
    /// Загрузка прошла успешно
    case success
    /// Загрузка была выполена неуспешно
    case failture
}
