//
//  UIColor.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/03/31.
//

import UIKit

extension UIColor {
    // MARK: hex code를 이용하여 정의
    // ex. UIColor(hex: 0xF5663F)
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    // MARK: 메인 테마 색 또는 자주 쓰는 색을 정의
    // ex. label.textColor = .mainOrange
    class var pointOrange: UIColor { UIColor(hex: 0xF3B368) }
    class var mainBrown: UIColor { UIColor(hex: 0x643D19) }
    class var mainYellow: UIColor { UIColor(hex: 0xD4AD62) }
}

