//
//  RegisterObituaryCustomTextField.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/12.
//

import UIKit

class RegisterObituaryCustomTextField: UITextField {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderColor = UIColor(hex: 0x9F9F9F).cgColor
    }
}
