//
//  Policy.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/03/31.
//

import Foundation

struct AllPolicy: Codable {
    var id: String
    var result: Bool
    var policy: [PolicyEntity]
    var code: [CodeEntity]
    var appMenu: [AppMenuEntity]
    var coordinates: [CoordinateEntity]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case result
        case policy
        case code
        case appMenu = "app_menu"
        case coordinates
    }
}

struct PolicyEntity: Codable {
    var id: String
    var name: String
    var value: String
}

struct CodeEntity: Codable {
    var cd: String
    var name: String
    var nameEn: String
    var categoryCd: String
    var categoryName: String
    
    enum CodingKeys: String, CodingKey {
        case cd
        case name
        case nameEn = "name_en"
        case categoryCd = "category_cd"
        case categoryName = "category_name"
    }
}


struct AppMenuEntity: Codable {
    var cd: String
    var name: String
    var nameEn: String
    var categoryCd: String
    var categoryName: String
    var iconName: String?
    var useYN: String
    
    enum CodingKeys: String, CodingKey {
        case cd
        case name
        case nameEn = "name_en"
        case categoryCd = "category_cd"
        case categoryName = "category_name"
        case iconName = "icon_name"
        case useYN = "use_yn"
    }
}

struct CoordinateEntity: Codable {
    var id: String
    var name: String
    var xvalue: Double
    var yvalue: Double
}
