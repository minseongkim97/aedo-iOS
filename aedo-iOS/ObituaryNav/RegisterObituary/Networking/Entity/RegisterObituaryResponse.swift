//
//  RegisterObituaryResponse.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/13.
//

import Foundation

struct RegisterObituaryResponse: Codable {
    var status: String
    var obituary: ObituaryResponse
}
