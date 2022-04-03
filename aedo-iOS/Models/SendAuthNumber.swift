//
//  SebdAuthNumberResponse.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/02.
//

import Foundation

struct SendAuthNumberRequest: Codable {
    var phone: String
}

struct SendAuthNumberResponse: Codable {
    var userAuthNumber: Int
    
    enum CodingKeys: String, CodingKey {
        case userAuthNumber = "user_auth_number"
    }
}
