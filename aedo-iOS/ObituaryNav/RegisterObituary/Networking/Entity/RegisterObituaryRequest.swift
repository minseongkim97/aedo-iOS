//
//  RegisterObituaryRequest.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/13.
//

import Foundation

struct RegisterObituaryRequest: Codable {
    var relation: String
    var residentName: String
    var residentphone: String
    var deceasedName: String
    var deceasedAge: String
    var place: String
    var eod: String
    var coffin: String
    var dofp: String
    var buried: String?
    var word: String?
    var created: String
}
