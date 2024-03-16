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
        if let imageData = fileManager.getImageFrom(url.absoluteString) {
            completionHandler(imageData, nil, nil)
        } else {
            service?.getImageFrom(url, completionHandler: { [weak self] data, response, error in
                self?.fileManager.saveImage(data, imageUri: url.absoluteString)
                completionHandler(data, response, error)
            })
        }
    }
}
