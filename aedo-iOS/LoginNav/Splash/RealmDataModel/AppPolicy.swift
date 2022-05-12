//
//  AppPolicy.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/03/31.
//

import Foundation
import RealmSwift

class AppPolicy: Object {
    @objc dynamic var _id: String = ""
    @objc dynamic var result: Bool = false
    dynamic var policy = List<Policy>()
    dynamic var code = List<Code>()
    dynamic var app_menu = List<AppMenu>()
    dynamic var coordinates = List<Coordinate>()
    
    override class func primaryKey() -> String? {
        return "_id"
    }
}

class Policy: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var value: String = ""
}

class Code: Object {
    @objc dynamic var cd: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var name_en: String = ""
    @objc dynamic var category_cd: String = ""
    @objc dynamic var category_name: String = ""
}


class AppMenu: Object {
    @objc dynamic var cd: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var name_en: String = ""
    @objc dynamic var category_cd: String = ""
    @objc dynamic var category_name: String = ""
    @objc dynamic var icon_name: String? = nil
    @objc dynamic var use_yn: String = ""
}

class Coordinate: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var xvalue: Double = 0
    @objc dynamic var yvalue: Double = 0
}
