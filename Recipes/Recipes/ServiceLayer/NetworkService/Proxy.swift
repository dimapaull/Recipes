// Proxy.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class Proxy: DownloadImageProtocol {
    private var service: DownloadImageProtocol?
    private let fileManager = FileManagerService.fileManagerService

    init(service: DownloadImageProtocol) {
        self.service = service
    }

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
