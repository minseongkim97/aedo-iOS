//
//  WithdrawalViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/14.
//

import UIKit

class WithdrawalViewController: UIViewController {
    //MARK: - Properties
    static let identifier = "WithdrawalViewController"
    let authService = AuthService()
    let userInfoService = UserService()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var authNumberTextField: CustomTextField!
    @IBOutlet weak var checkAuthNumberButton: UIButton!
    @IBOutlet weak var sendAuthNumberButton: CustomCheckButton!
    @IBOutlet weak var authNumberStack: UIStackView!
    @IBOutlet private weak var noticeView: UIView!
    @IBOutlet weak var checkView: UIView!
    @IBOutlet weak var noticeCheckButton: UIButton!
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserInfo()
        setContribute()
    }
    
    //MARK: - Actions
    @IBAction func didTappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTappedRemoveAuthNumberButton(_ sender: UIButton) {
        authNumberTextField.text = ""
    }
    
    @IBAction func didTappedSendAuthNumber(_ sender: UIButton) {
        sendAuthNumber()
    }
    
    @IBAction func didTappedWithDrawalButton(_ sender: UIButton) {
        withdrawal()
    }
    
    @IBAction func didTappedAgreeButton(_ sender: UIButton) {
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
    //MARK: - Helpers
    private func setContribute() {
        dismissKeyboardWhenTappedAround()
        titleLabel.text =  "회원을\n탈퇴하시겠습니까?"
        descriptionLabel.text = "회원탈퇴를 진행하려면\n인증번호 전송을 눌러주세요."
        
        noticeView.layer.borderWidth = 1
        noticeView.layer.borderColor = UIColor(hex: 0xDDDDDD).cgColor
        noticeView.layer.cornerRadius = 10
    }
    
    private func getUserInfo() {
        userInfoService.getUserInfo { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.phoneNumberLabel.text = response.user.phone
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.showCustomAlert(alertType: .PopError, alertTitle: "회원 정보를 불러오는데 실패하였습니다.", isRightButtonHidden: true, leftButtonTitle: "확인")
                }
            }
        }
    }

    
    private func sendAuthNumber() {
        authService.sendAuthNumber(at: phoneNumberLabel.text!) { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.titleLabel.text =  "인증번호를 \n입력해주세요."
                    self?.descriptionLabel.text = "인증번호 입력 후 약관에 동의하면 탈퇴가 완료됩니다."
                    self?.authNumberTextField.text = ""
                    self?.authNumberStack.isHidden = false
                    self?.sendAuthNumberButton.isHidden = true
                    self?.checkView.isHidden = false
                    self?.authNumberTextField.becomeFirstResponder()
                }
               
            case .failure(_):
                DispatchQueue.main.async {
                    self?.showCustomAlert(alertType: .none, alertTitle: "인증번호를 다시 확인해주세요.", isRightButtonHidden: true, leftButtonTitle: "확인", isMessageLabelHidden: true)
                }
            }
        }
    }
    
    private func withdrawal() {
        if noticeCheckButton.isSelected {
            authService.withdrawal { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self.showCustomAlert(alertType: .Withdrawal, alertTitle: "회원탈퇴에 성공하셨습니다.", isRightButtonHidden: true, leftButtonTitle: "확인", isMessageLabelHidden: true)
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self.showCustomAlert(alertType: .none, alertTitle: "네트워크가 원활하지 않습니다.\n다시 시도해주세요.", isRightButtonHidden: true, leftButtonTitle: "확인", isMessageLabelHidden: true)
                    }
                }
            }
        } else {
            showCustomAlert(alertType: .none, alertTitle: "인증번호와 유의사항 동의를 확인해주세요.", isRightButtonHidden: true, leftButtonTitle: "확인", isMessageLabelHidden: true)
        }
        
    }
}
