//
//  OrderWreathResponse.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/06/29.
//

import Foundation

struct OrderWreathResponse: Codable {
    var status: String
    var order: WreathResponse
}

struct WreathResponse: Codable {
    var place: PlaceInfo
    var item: String
    var price: String
    var receiver: Receiver
    var sender: Sender
    var word: Word
    var created: String
    var userId: String
    var id: String
}
