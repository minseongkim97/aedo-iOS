//
//  Term.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/02.
//

import Foundation

struct Term: Codable {
    var title: String
    var subTitle: String
    var first: String
    var second: String
    var third: String
    var fourth: String
    var fifth: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case subTitle = "sub_title"
        case first
        case second
        case third
        case fourth
        case fifth
    }
}
