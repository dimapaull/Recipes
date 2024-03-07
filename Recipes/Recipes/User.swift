// User.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// sdsd
struct User: Codable, Equatable {
    let login: String
    let password: String
    var profileImage: Data?
    var userName: String?
}
