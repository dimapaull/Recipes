// FileManagerService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Используется для кеширования данных в песочницу
protocol FileManagerServiceProtocol: AnyObject {
    /// Сохраняет логи на экранах пользователя
    func setTitleSection(nameSection: String)
    /// Получает изображение из песочницы
    func getImageFrom(name: String) -> Data?
    /// Сохраняет изображение в песочницу
    func saveImage(data: Data?, imageUri: String)
}

/// Класс с сервисом сохранения данных в песочницу, имеет синглтон
final class FileManagerService {
    static let fileManagerService = FileManagerService()
    private var text = ""

    private func saveLogs(text: String) {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask)[0]

        let newFolderUrl = url.appendingPathComponent("recipeApp", conformingTo: .folder)
        do {
            try manager.createDirectory(at: newFolderUrl, withIntermediateDirectories: true, attributes: [:])
        } catch {
            return
        }

        do {
            let fileURL = newFolderUrl.appendingPathComponent("logs.txt")
            try "\(text)".write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            return
        }
    }

//    private func getPathForImage(_ name: String) -> URL? {
//        let testPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
//        print(testPath)
//        guard let path = FileManager.default.urls(
//            for: .cachesDirectory,
//            in: .userDomainMask
//        ).first?.appendingPathComponent("\(name).jpg") else { return nil }
//        return path
//    }
}

// MARK: - FileManagerService + FileManagerServiceProtocol

extension FileManagerService: FileManagerServiceProtocol {
    func setTitleSection(nameSection: String) {
        text.append("Пользователь \(nameSection)\n")
        saveLogs(text: text)
    }

    func getImageFrom(name: String) -> Data? {
        guard let url = FileManager.default.urls(
            for: .cachesDirectory,
            in:
            .userDomainMask
        ).first?.appendingPathComponent(name)
        else { return nil }
        let data = try? Data(contentsOf: url)
        return data
    }

    func saveImage(data: Data?, imageUri: String) {
        do {
            guard let folder = FileManager.default.urls(
                for: .cachesDirectory,
                in:
                .userDomainMask
            ).first?.appendingPathComponent("Savedimage")
            else {
                return
            }
            try? FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
            let fileURL = folder.appendingPathComponent(imageUri)
            try data?.write(to: fileURL)
        } catch {}
    }
}
