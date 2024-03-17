// Proxy.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Заместитель для скачивания изображения из интернета, скачанное кешируется
final class Proxy: DownloadImageProtocol {
    // MARK: - Private Properties

    private var service: DownloadImageProtocol?
    private let fileManager = FileManagerService.fileManagerService

    // MARK: - Initializers

    init(service: DownloadImageProtocol) {
        self.service = service
    }

    // MARK: - Private Methods

    func getImageFrom(_ url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let imageName = url.lastPathComponent
        if let casheData = fileManager.getImageFrom(name: imageName) {
            completionHandler(casheData, nil, nil)
        } else {
            service?.getImageFrom(url) { data, response, error in
                self.fileManager.saveImage(data: data, imageUri: imageName)
                completionHandler(data, response, error)
            }
        }
    }
}
