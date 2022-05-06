//
//  ObituaryMessageListResponse.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/05.
//

import Foundation

struct CondoleMessageListResponse: Codable {
    var condoleMessage: [CondoleMessage]
}

struct CondoleMessage: Codable {
        var title: String
        var content: String
        var name: String
        var created: String
        var obId: String
        var userId: String
        var id: String
}
