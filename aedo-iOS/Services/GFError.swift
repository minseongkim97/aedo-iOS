//
//  GFError.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/03/31.
//

import Foundation

enum GFError: String, Error {
    case invalidURL
    case invalidRequest
    case unableToComplete
    case invalidResponse
    case invalidData
    case networkError
    case notUser    // 404
    case unknown
}
