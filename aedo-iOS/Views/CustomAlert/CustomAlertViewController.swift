//
//  CustomAlertViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/03/31.
//

import UIKit

protocol CustomAlertDelegate: AnyObject {
    func leftButtonPressed(_ alert: CustomAlertViewController, alertType: AlertType)
    func rightButtonPressed(_ alert: CustomAlertViewController, alertType: AlertType)
}

enum AlertType {
    case NetworkError
    case SystemMaintenance
    case AppVersionUpdate
    case PermissionError
    case none
}

class CustomAlertViewController: UIViewController {
    //MARK: - Properties
    private let identifier = "CustomAlertViewController"
    weak var delegate: CustomAlertDelegate?
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var leftButton: UIButton!
    @IBOutlet private weak var rightButton: UIButton!
    
    
    var alertTitle = ""
    var alertMessage = ""
    var leftButtonTitle = ""
    var rightButtonTitle = ""
    var alertType: AlertType = .none
    var isRightButtonHidden = false
    var isMessageLabelHidden = false
    
    //MARK: - Initialize
    init() {
        super.init(nibName: identifier, bundle: Bundle(for: CustomAlertViewController.self))
        
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAlert()
    }

    //MARK: - Action
    @IBAction func didTappedLeftButton(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        delegate?.leftButtonPressed(self, alertType: alertType)
    }

    @IBAction func didTappedRightButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        delegate?.rightButtonPressed(self, alertType: alertType)
    }
    
    //MARK: - Helper
    func show() {
        DispatchQueue.main.async {
            UIApplication.shared.windows.first?.rootViewController?.present(self, animated: true, completion: nil)
        }
    }

    
    private func setupAlert() {
        titleLabel.text = alertTitle
        messageLabel.text = alertMessage
        leftButton.setTitle(leftButtonTitle, for: .normal)
        rightButton.setTitle(rightButtonTitle, for: .normal)
        rightButton.isHidden = isRightButtonHidden
        messageLabel.isHidden = isMessageLabelHidden
    }
    

}

