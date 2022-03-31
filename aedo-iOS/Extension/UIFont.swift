//
//  UIFont.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/03/31.
//

import UIKit

extension UIFont {
    public enum NotoSansType: String {
        case bold = "Bold"
        case medium = "Medium"
        case regular = "Regular"
    }

    // ex. label.font = .NotoSans(.medium, size: 16)
    static func NotoSans(_ type: NotoSansType, size: CGFloat) -> UIFont {
        return UIFont(name: "NotoSansCJKkr-\(type.rawValue)", size: size)!
    }
}
