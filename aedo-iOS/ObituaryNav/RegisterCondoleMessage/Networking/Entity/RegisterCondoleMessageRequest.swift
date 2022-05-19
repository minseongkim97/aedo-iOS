//
//  RegisterCondoleMessageRequest.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/17.
//

import Foundation

struct RegisterCondoleMessageRequest: Codable {
    var title: String
    var content: String
    var created: String
    var obId: String
}
