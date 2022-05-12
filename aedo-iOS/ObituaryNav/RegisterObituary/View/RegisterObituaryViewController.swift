//
//  RegisterObituaryViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/12.
//

import UIKit

class RegisterObituaryViewController: UIViewController {
    //MARK: - Properties
    static let identifier = "RegisterObituaryViewController"
    @IBOutlet weak var relationPicker: RegisterObituaryCustomTextField!
    @IBOutlet weak var relationTextButton: UIButton!
    @IBOutlet weak var residentNameTextField: RegisterObituaryCustomTextField!
    @IBOutlet weak var residentPhoneNumberTextField: RegisterObituaryCustomTextField!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK: - Actions
    
    //MARK: - Helpers
    private func setConfigure() {
        let rightButton = UIButton()
        let relationPickerRightImage = UIImage(systemName: "arrowtriangle.down.fill")
        rightButton.setBackgroundImage(relationPickerRightImage, for: .normal)
        relationPicker.rightView = rightButton
        relationPicker.rightViewMode = .always
        
        relationTextButton.layer.borderColor = UIColor.init(hex: 0x9F9F9F).cgColor
    }
}
