//
//  UIViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/03/31.
//

import UIKit

extension UIViewController: CustomAlertDelegate {
    
    // MARK: 빈 화면을 눌렀을 때 키보드가 내려가도록 처리
    func dismissKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    // MARK: UIWindow의 rootViewController를 변경하여 화면전환
    func changeRootViewController(_ viewControllerToPresent: UIViewController) {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = viewControllerToPresent
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        } else {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.present(viewControllerToPresent, animated: true, completion: nil)
        }
    }
    
    //MARK: - CustomAlert 띄우기
    func showCustomAlert(alertType: AlertType, alertTitle: String, alertMessage: String = "", isRightButtonHidden: Bool, leftButtonTitle: String = "종료", rightButtonTitle: String = "업데이트", isMessageLabelHidden: Bool = false) {
        let customAlert = CustomAlertViewController()
        customAlert.alertType = alertType
        customAlert.alertTitle = alertTitle
        customAlert.alertMessage = alertMessage
        customAlert.isRightButtonHidden = isRightButtonHidden
        customAlert.leftButtonTitle = leftButtonTitle
        customAlert.rightButtonTitle = rightButtonTitle
        customAlert.isMessageLabelHidden = isMessageLabelHidden
        customAlert.delegate = self
        customAlert.show()
    }
    
    //MARK: - 앱스토어로 이동
    func openAppstore(to appleID: String) {
        // UIApplication 은 Main Thread 에서 처리
        DispatchQueue.main.async {
            if let url = URL(string: "itms-apps://itunes.apple.com/app/\(appleID)"), UIApplication.shared.canOpenURL(url) {
                
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                
            }
        }
    }
    
    
    func leftButtonPressed(_ alert: CustomAlertViewController, alertType: AlertType) {
        switch alertType {
        case .NetworkError, .SystemMaintenance, .AppVersionUpdate, .PermissionError:
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                exit(0)
            }
        default:
            break
        }
    }
    
    func rightButtonPressed(_ alert: CustomAlertViewController, alertType: AlertType) {
        switch alertType {
        case .AppVersionUpdate:
            openAppstore(to: Constant.APPLE_ID)
        default:
            break
        }
    }
    
    
}
