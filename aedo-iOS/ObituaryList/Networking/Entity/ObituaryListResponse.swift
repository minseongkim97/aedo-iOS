//
//  ObituaryList.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/02.
//

import Foundation

struct ObituaryListResponse: Codable {
        var status: String
        var result: [ObituaryResponse]
}

struct ObituaryResponse: Codable {
    var id: String
    var imgName: String
    var resident: Resident
    var place: String
    var deceased: Deceased
    var eod: String
    var coffin: String
    var dofp: String
    var buried: String
    var word: String
    var userId: String
    var created: String
    
}

struct Resident: Codable {
    var relation: String
    var name: String
    var phone: String
}

struct Deceased: Codable {
    var name: String
    var age: String
}
