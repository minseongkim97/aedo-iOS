//
//  AuthViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/01.
//

import UIKit
import SwiftUI

class AuthViewController: UIViewController {
    //MARK: - Properties
    static let identifier = "AuthViewController"
    let authService = AuthService()
    
    @IBOutlet private weak var authView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var scriptLabel: UILabel!
    @IBOutlet private weak var removePhoneNumberButton: UIButton!
    @IBOutlet private weak var phoneNumberTextField: CustomTextField!
    @IBOutlet private weak var phoneNumberLine: UIView!
    @IBOutlet private weak var authenticationNumberTextField: CustomTextField!
    @IBOutlet private weak var authenticationNumberLine: UIView!
    @IBOutlet private weak var checkAuthenticationNumberButton: UIButton!
    @IBOutlet private weak var authenticationNumberStack: UIStackView!
    @IBOutlet private weak var refunctionStack: UIStackView!
    @IBOutlet private weak var signUpView: UIView!
    @IBOutlet private weak var phoneNumberLabel: UILabel!
    @IBOutlet private weak var birthdayTextField: CustomTextField!
    @IBOutlet private weak var birthdayLine: UIView!
    @IBOutlet private weak var nameTextField: CustomTextField!
    @IBOutlet private weak var nameLine: UIView!
    @IBOutlet private weak var termLabel: UILabel!
    @IBOutlet private weak var agreeCheckButton: UIButton!
    @IBOutlet private weak var signUpCheckButton: CustomCheckButton!
    
    @IBOutlet private weak var sendAuthenticationNumberButton: CustomCheckButton!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        set()
    }
    //MARK: - Actions
    @IBAction func didTappedRemovePhoneNumberButton(_ sender: UIButton) {
        phoneNumberTextField.text = ""
    }
    
    @IBAction func didTappedSendAuthNumberButton(_ sender: CustomCheckButton) {
        if isValidPhone(phone: phoneNumberTextField.text) {
            sendAuthNumber()
        } else {
            showCustomAlert(alertType: .none, alertTitle: "??????????????? ?????? ????????? ?????????.", isRightButtonHidden: true, leftButtonTitle: "??????", isMessageLabelHidden: true)
        }
    }
    
    @IBAction private func didTappedCheckAuthenticationNumberButton(_ sender: UIButton) {
        login()
    }
    
    
    @IBAction private func didTappedReEnterPhoneNumberButton(_ sender: UIButton) {
        titleLabel.text =  "???????????? ????????? \n??????????????????."
        scriptLabel.text = "???????????????. ???????????????. \n???????????? ?????? ???????????? ????????? ??????????????????."
        phoneNumberTextField.text = ""
        phoneNumberTextField.isUserInteractionEnabled = true
        authenticationNumberTextField.isUserInteractionEnabled = true
        checkAuthenticationNumberButton.isUserInteractionEnabled = true
        authenticationNumberStack.isHidden = true
        refunctionStack.isHidden = true
        removePhoneNumberButton.isHidden = false
        sendAuthenticationNumberButton.isHidden = false
        signUpView.isHidden = true
        phoneNumberTextField.becomeFirstResponder()
    }

    @IBAction private func didTappedResendAuthenticationNumberButton(_ sender: UIButton) {
        authenticationNumberTextField.isUserInteractionEnabled = true
        checkAuthenticationNumberButton.isUserInteractionEnabled = true
        signUpView.isHidden = true
        authenticationNumberTextField.text = ""
        sendAuthNumber()
    }
    
    @IBAction private func didTappedAgreeAppTermsButton(_ sender: UIButton) {
        if !sender.isSelected {
            sender.isSelected = true
            sender.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            sender.tintColor = .mainBrown
        } else {
            sender.isSelected = false
            sender.setImage(UIImage(systemName: "square"), for: .normal)
            sender.tintColor = UIColor(hex: 0x878787)
        }
    }
    
    @IBAction func didTappedSignUpButton(_ sender: UIButton) {
        var alertTitle = ""
        if !isValidBirthday(birthday: birthdayTextField.text) {
            alertTitle = "??????????????? ?????? ????????? ?????????"
            showCustomAlert(alertType: .none, alertTitle: alertTitle, isRightButtonHidden: true, leftButtonTitle: "??????", isMessageLabelHidden: true)
        } else if !agreeCheckButton.isSelected {
            alertTitle = "?????? ????????? ?????? ????????? ?????????"
            showCustomAlert(alertType: .none, alertTitle: alertTitle, isRightButtonHidden: true, leftButtonTitle: "??????", isMessageLabelHidden: true)
        } else {
            signUp()
        }
    }
    
    //MARK: - @objc functions
    @objc func didTappedTermLabel(sender: UIPanGestureRecognizer) {
        let termViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PrivateInfoAccessViewController")
        termViewController.modalPresentationStyle = .fullScreen
        self.present(termViewController, animated: true, completion: nil)
    }
    
    //MARK: - Helpers
    private func set() {
        dismissKeyboardWhenTappedAround()
        titleLabel.text =  "???????????? ????????? \n??????????????????."
        scriptLabel.text = "???????????????. ???????????????. \n???????????? ?????? ???????????? ????????? ??????????????????."
        
        guard let text = self.termLabel.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: UIColor.mainBrown, range: (text as NSString).range(of: "???????????? ??????, ?????????????????? ??????, ???3??????????????? ??????, ?????? ???????????? ??????"))
        termLabel.attributedText = attributeString
        termLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTappedTermLabel(sender:)))
        termLabel.addGestureRecognizer(tapGesture)
        
        agreeCheckButton.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
    }
    
    private func setDelegate() {
        phoneNumberTextField.delegate = self
        authenticationNumberTextField.delegate = self
        birthdayTextField.delegate = self
        nameTextField.delegate = self
    }
    
    private func isValidPhone(phone: String?) -> Bool {
        guard phone != nil else { return false }

        let phoneRegEx = "[0-9]{11}"
        let pred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return pred.evaluate(with: phone)
    }
    
    
    private func isValidBirthday(birthday: String?) -> Bool {
        guard birthday != nil else { return false }
        
        let birthdayRegEx = "[0-9]{6}"
        let pred = NSPredicate(format:"SELF MATCHES %@", birthdayRegEx)
        return pred.evaluate(with: birthday)
    }
    
    
    private func sendAuthNumber() {
        authService.sendAuthNumber(at: phoneNumberTextField.text!) { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    
                    self?.titleLabel.text =  "??????????????? \n??????????????????."
                    self?.scriptLabel.text = "??????????????? ????????? 4????????? \n??????????????? ??????????????????."
                    self?.authenticationNumberTextField.text = ""
                    self?.phoneNumberTextField.isUserInteractionEnabled = false
                    
                    self?.authenticationNumberStack.isHidden = false
                    self?.refunctionStack.isHidden = false
                    self?.removePhoneNumberButton.isHidden = true
                    self?.sendAuthenticationNumberButton.isHidden = true

                    self?.authenticationNumberTextField.becomeFirstResponder()
                }
               
            case .failure(_):
                DispatchQueue.main.async {
                    self?.showNetworkErrorAlert()
                }
            }
        }
    }
    
    private func login() {
        authService.login(with: phoneNumberTextField.text!, smsnumber: authenticationNumberTextField.text!) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    AccessToken.logInAccessToken = response.Accesstoken
                    AccessToken.autoLogInAccessToken = response.Accesstoken
                    UserDefaults.standard.set(true, forKey: "autoLogin")
                    let mainViewController = UIStoryboard(name: "MainNav", bundle: nil).instantiateViewController(identifier: MainViewController.identifier)
                    let navVC = UINavigationController(rootViewController: mainViewController)
                    navVC.isNavigationBarHidden = true
                    self?.changeRootViewController(navVC)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                if error == .notUser {
                    DispatchQueue.main.async {
                        self?.titleLabel.text =  "??????????????? \n??????????????????."
                        self?.scriptLabel.text = "??????????????? ????????? 4????????? \n??????????????? ??????????????????."

                        self?.authenticationNumberTextField.isUserInteractionEnabled = false
                        
                        self?.signUpView.isHidden = false
                        self?.phoneNumberLabel.text = self?.phoneNumberTextField.text
                        self?.birthdayTextField.becomeFirstResponder()
                    }
                } else if error == .invalidResponse {
                    DispatchQueue.main.async {
                        self?.showCustomAlert(alertType: .none, alertTitle: "???????????? ?????? ??????????????? ?????? ????????? ?????????.", isRightButtonHidden: true, leftButtonTitle: "??????", isMessageLabelHidden: true)
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.showNetworkErrorAlert()
                    }
                }
            }
        }
    }
    
    private func signUp() {
        authService.signUp(phone: phoneNumberTextField.text!,
                           birth: birthdayTextField.text!,
                           name: nameTextField.text!,
                           terms: agreeCheckButton.isSelected,
                           smsnumber: authenticationNumberTextField.text!
        ) { [weak self] result in
            switch result {
            case .success(let response):
                AccessToken.signUpAccessToken = response.Accesstoken
                UserDefaults.standard.set(true, forKey: "autoLogin")
                self?.login()
            default:
                DispatchQueue.main.async {
                    self?.showNetworkErrorAlert()
                }
            }
        }
    }
}

//MARK: - Extension
extension AuthViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case phoneNumberTextField:
            phoneNumberLine.backgroundColor = .mainBrown
        case authenticationNumberTextField:
            authenticationNumberLine.backgroundColor = .mainBrown
        case birthdayTextField:
            birthdayLine.backgroundColor = .mainBrown
        case nameTextField:
            nameLine.backgroundColor = .mainBrown
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case phoneNumberTextField:
            phoneNumberLine.backgroundColor = .lightGray
        case authenticationNumberTextField:
            authenticationNumberLine.backgroundColor = .lightGray
        case birthdayTextField:
            birthdayLine.backgroundColor = .lightGray
        case nameTextField:
            nameLine.backgroundColor = .lightGray
        default:
            break
        }
    }
}
