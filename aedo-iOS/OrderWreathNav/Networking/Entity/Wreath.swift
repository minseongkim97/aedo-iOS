//
//  OrderWreathRequest.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/06/29.
//

import Foundation

struct Wreath: Codable {
    var place: PlaceInfo
    var receiver: Receiver
    var sender: Sender
    var word: Word
    var item: String
    var price: Int
    var created: String
}

struct PlaceInfo: Codable {
    var name: String
    var number: String
}

struct Receiver: Codable {
    var name: String
    var phone: String
}

struct Sender: Codable {
    var name: String
    var phone: String
}

struct Word: Codable {
    var company: String
    var word: String
    var wordsecond: String
}

