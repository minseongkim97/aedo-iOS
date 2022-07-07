//
//  AccessToken.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/01.
//

import Foundation

class AccessToken {
    static var token = ""
    
    static var signUpAccessToken: String = UserDefaults.standard.string(forKey: "signUpAccessToken") ?? "" {
        didSet {
            AccessToken.token = signUpAccessToken
            UserDefaults.standard.set(signUpAccessToken, forKey: "signUpAccessToken")
        }
    }
    
    static var logInAccessToken: String = UserDefaults.standard.string(forKey: "logInAccessToken") ?? "" {
        didSet {
            AccessToken.token = logInAccessToken
            UserDefaults.standard.set(logInAccessToken, forKey: "logInAccessToken")
        }
    }
    
    static var autoLogInAccessToken: String = UserDefaults.standard.string(forKey: "autoLogInAccessToken") ?? "" {
        didSet {
            AccessToken.token = autoLogInAccessToken
            UserDefaults.standard.set(autoLogInAccessToken, forKey: "autoLogInAccessToken")
            print(UserDefaults.standard.string(forKey: "autoLogInAccessToken")!)
        }
    }
}
