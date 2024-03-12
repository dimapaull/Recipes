// FileManagerService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

protocol FileManagerServiceProtocol: AnyObject {
    func setTitleSection(nameSection: String)
}

/// Класс с сервисом
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
            print(error)
        }

        do {
            let fileURL = newFolderUrl.appendingPathComponent("logs.txt")
            try "\(text)".write(to: fileURL, atomically: true, encoding: .utf8)

            let content = try String(contentsOf: fileURL)
            print(content)
        } catch {
            print("Error: \(error)")
        }
    }
}

extension FileManagerService: FileManagerServiceProtocol {
    func setTitleSection(nameSection: String) {
        text.append("Пользователь \(nameSection)\n")
        bullShit(text: text)
    }
}
