//
//  AccessToken.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/01.
//

import Foundation

class AccessToken {
    
    static var token: String = UserDefaults.standard.string(forKey: "signUpAceessToken") ?? ""
    
    static var signUpAceessToken: String = UserDefaults.standard.string(forKey: "signUpAceessToken") ?? "" {
        didSet {
            AccessToken.token = signUpAceessToken
        }
    }
    
    static var logInAceessToken: String = UserDefaults.standard.string(forKey: "logInAceessToken") ?? "" {
        didSet {
            AccessToken.token = logInAceessToken
        }
    }
}
