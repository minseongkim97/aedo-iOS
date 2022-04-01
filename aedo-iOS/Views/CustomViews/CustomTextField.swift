//
//  CustomTextField.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/02.
//

import UIKit

class CustomTextField: UITextField {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        placeholderAttributted()
    }
    
    func placeholderAttributted() {
        
        attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [.foregroundColor: UIColor.systemGray, .font: UIFont.NotoSans(.medium, size: 15)])
        keyboardAppearance = .light
        
    }
    
}

