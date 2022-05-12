//
//  LogInResponse.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/02.
//

import Foundation

struct LogInRequest: Codable {
    var phone: String
    var smsnumber: String
}

struct LogInResponse: Codable {
    var status: String
    var Accesstoken: String
    var userId: String
}
