//
//  User.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/14.
//

import Foundation

struct User: Codable {
    var user: UserRepsonse
}

struct UserRepsonse: Codable {
    var id: String
    var phone: String
    var birth: String
    var name: String
    var terms: String
    var admin: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case phone, birth, name, terms, admin
    }
}
