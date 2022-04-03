//
//  AutoLogInResponse.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/01.
//

import Foundation

struct AutoLogInResponse: Codable {
    var status: String
    var accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case status
        case accessToken = "Accesstoken"
    }
}
