// FileManagerService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Используется для кеширования данных в песочницу
protocol FileManagerServiceProtocol: AnyObject {
    /// Сохраняет логи на экранах пользователя
    func setTitleSection(nameSection: String)
    /// Получает изображение из песочницы
    func getImageFrom(_ name: String) -> Data?
    /// Сохраняет изображение в песочницу
    func saveImage(_ data: Data?, imageUri: String)
}

/// Класс с сервисом сохранения данных в песочницу, имеет синглтон
final class FileManagerService {
    static let fileManagerService = FileManagerService()
    private var text = ""

    private func bullShit(text: String) {
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

    private func getPathForImage(_ name: String) -> URL? {
        guard let path = FileManager.default.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        ).first?.appendingPathComponent("\(name).jpg") else { return nil }
        return path
    }
}

// MARK: - FileManagerService + FileManagerServiceProtocol

extension FileManagerService: FileManagerServiceProtocol {
    func setTitleSection(nameSection: String) {
        text.append("Пользователь \(nameSection)\n")
        bullShit(text: text)
    }

    func getImageFrom(_ name: String) -> Data? {
        guard let path = getPathForImage(name)?.path, FileManager.default.fileExists(atPath: path) else { return nil }

        return UIImage(contentsOfFile: path)?.jpegData(compressionQuality: 1.0)
    }

    func saveImage(_ data: Data?, imageUri: String) {
        guard let data = data,
              let image = UIImage(data: data),
              let jpegData = image.jpegData(compressionQuality: 1.0),
              let path = getPathForImage(imageUri)
        else {
            return
        }

        do {
            try jpegData.write(to: path)
        } catch {
            return
        }
    }
}
