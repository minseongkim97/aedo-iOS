//
//  AccessToken.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/01.
//

import Foundation

class AccessToken {
    
//    static var token: String = UserDefaults.standard.string(forKey: "AceessToken") ?? ""
    static var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyNzQ4NDAzMTYwNzgxZDI3OWVkZTYzMyIsImlhdCI6MTY1MTg2MDcxNiwiZXhwIjoxNjUxODY0MzE2fQ.-mRdG_Aw5hl9MwWl7zM_BZAb8ptUCcvY-ugUl0gAZZs"
    
    static var signUpAceessToken: String = UserDefaults.standard.string(forKey: "signUpAceessToken") ?? "" {
        didSet {
            AccessToken.token = signUpAceessToken
            UserDefaults.standard.set(signUpAceessToken, forKey: "AceessToken")
        }
    }
    
    static var logInAceessToken: String = UserDefaults.standard.string(forKey: "logInAceessToken") ?? "" {
        didSet {
            AccessToken.token = logInAceessToken
            UserDefaults.standard.set(logInAceessToken, forKey: "AceessToken")
        }
    }
}
