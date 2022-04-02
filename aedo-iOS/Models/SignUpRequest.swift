//
//  SignUpRequest.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/02.
//

import Foundation

struct SignUpRequest: Codable {
    var phone: String
    var birth: String
    var name: String
    var terms: Bool
}
