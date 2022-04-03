//
//  Announcemnet.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/02.
//

import Foundation

struct AllAnnouncementResponse: Codable {
    var status: String
    var result: [Announcement]
}

struct AnnouncementResponse: Codable {
    var status: String
    var result: Announcement
}

struct Announcement: Codable {
    var id: String
    var title: String
    var content: String
    var created: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title, content, created
    }
}
