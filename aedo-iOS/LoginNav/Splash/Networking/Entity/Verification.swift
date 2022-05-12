//
//  Verification.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/03/31.
//

import Foundation

struct Verification: Codable {
    var result: Bool
    var appToken: [AppTokenEntity]
    var encrypt: [EncryptEntity]
    var policyVer: [PolicyVerEntity]
    var id: String
    
    enum CodingKeys: String, CodingKey {
        case result
        case appToken = "app_token"
        case encrypt
        case policyVer = "policy_ver"
        case id = "_id"
    }
}

struct AppTokenEntity: Codable {
    var appToken: String?
}

struct EncryptEntity: Codable {
    var key: String
    var iv: String
}

struct PolicyVerEntity: Codable {
    var version: Int
}
