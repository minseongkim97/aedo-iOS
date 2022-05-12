//
//  AppVerification.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/03/31.
//

import Foundation
import RealmSwift

class AppVerification: Object {
    @objc dynamic var result: Bool = false
    @objc dynamic var _id: String = ""
    dynamic var app_token = List<AppToken>()
    dynamic var encrypt = List<Encrypt>()
    dynamic var policy_ver = List<PolicyVer>()
    
    override class func primaryKey() -> String? {
        return "_id"
    }
}

class AppToken: Object {
    @objc dynamic var appToken: String? = nil
}

class Encrypt: Object {
    @objc dynamic var key: String = ""
    @objc dynamic var iv: String = ""
}

class PolicyVer: Object {
    @objc dynamic var version: Int = 0
}

