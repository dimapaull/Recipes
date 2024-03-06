// FilterState.swift
// Copyright © RoadMap. All rights reserved.

/// Состояния фильтра
enum FilterType {
    /// Отключен
    case off
    /// От большего к меньшему
    case time
    /// От меньшего к большему
    case calories
    /// Включенные оба фильтра
    case twice
}
