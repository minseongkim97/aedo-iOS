//
//  CustomCheckButton.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/02.
//

import UIKit

class CustomCheckButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        backgroundColor = .pointOrange
        layer.cornerRadius = 10
        layer.masksToBounds = true
        titleLabel?.font = .NotoSans(.regular, size: 18)
        titleLabel?.textColor = .white
    }

}
