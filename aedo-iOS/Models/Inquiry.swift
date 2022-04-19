//
//  Inquiry.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/12.
//

import Foundation

struct InquiryList: Codable {
    var userRequest: [Inquiry]
    
    static func EMPTY() -> InquiryList {
        return InquiryList(userRequest: [])
    }
}

struct Inquiry: Codable {
    var id: String
    var name: String
    var title: String
    var phone: String
    var content: String
    var created: String
    var terms: Bool?
    var userId: String
}


