//
//  LogInResponse.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/02.
//

import Foundation

struct LogInResponse: Codable {
    var status: String
    var Accesstoken: String
    var userId: String
}
