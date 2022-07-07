//
//  Int.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/07/07.
//

import Foundation

extension Int {
    func currencyKR() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: NSNumber(value: self))?.replacingOccurrences(of: "₩", with: "") ?? ""
    }
}

