// DownloadState.swift
// Copyright © RoadMap. All rights reserved.

/// Описывает состояния загрузки данных
enum DownloadState {
    /// Процесс загрузки
    case loading
    /// Загрузка выполнена успешно
    case data
    /// Загрузка выполнена успешно, но данные отсутствуют
    case noData
    /// Загрузка выполнена неуспешно
    case error
}
