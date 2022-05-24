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
        setRightView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setRightView()
    }
    
    override var intrinsicContentSize: CGSize {
           return CGSize.zero
       }
    
    private func setRightView() {
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 21, height: 30))
        let rightImageView = UIImageView(frame: CGRect(x: 0, y: 10, width: 10, height: 10))
        rightImageView.contentMode = .scaleAspectFit
        rightImageView.tintColor = UIColor(hex: 0x676767)
        let relationPickerRightImage = UIImage(systemName: "arrowtriangle.down.fill")
        rightImageView.image = relationPickerRightImage
        rightView.addSubview(rightImageView)
        
        self.rightView = rightView
        self.rightViewMode = .always
    }
}
