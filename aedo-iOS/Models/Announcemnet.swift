//
//  Announcemnet.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/02.
//

import Foundation

struct AnnouncementList: Codable {
    var announcement: [Announcement]
}

struct AnnouncementResponse: Codable {
    var announcement: Announcement
}

struct Announcement: Codable {
    var id: String
    var title: String
    var content: String
    var created: String
}

extension AnnouncementList {
    static let EMPTY = AnnouncementList(announcement: [])
}
