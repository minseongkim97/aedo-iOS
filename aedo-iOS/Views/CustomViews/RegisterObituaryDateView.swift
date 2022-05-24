//
//  RegisterObituaryDateView.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/12.
//

import UIKit

class RegisterObituaryDateView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(hex: 0x9F9F9F).cgColor
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    override var intrinsicContentSize: CGSize {
           return CGSize.zero
    }
}
