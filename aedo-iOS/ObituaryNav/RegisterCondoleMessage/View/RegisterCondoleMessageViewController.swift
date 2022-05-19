//
//  RegisterCondoleMessageViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/16.
//

import UIKit

class RegisterCondoleMessageViewController: UIViewController {
    //MARK: - Properties
    static let identifier = "RegisterCondoleMessageViewController"
    let registerCondoleMessageService = RegisterCondoleMessageService()
    var obID: String = ""
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var condoleMessageTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setContribute()
        dismissKeyboardWhenTappedAround()
    }
    
    //MARK: - Actions
    @IBAction func didTappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTappedHomeButton(_ sender: UIButton) {
    }
    
    @IBAction func didTappedRegisterCondoleMessageButton(_ sender: UIButton) {
        registerCondoleMessageService.registerCondoleMessage(content: condoleMessageTextField.text ?? "조문 메시지",
                                                             name: nameTextField.text ?? "",
                                                             obID: self.obID
        ) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async { [weak self] in
                    self?.showCustomAlert(alertType: .PopSuccess, alertTitle: "조문 메시지를 등록하셨습니다.", isRightButtonHidden: true, leftButtonTitle: "확인", isMessageLabelHidden: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async { [weak self] in
                    switch error {
                    case .invalidRequest, .invalidResponse:
                        self?.showCustomAlert(alertType: .none, alertTitle: "입력하신 정보들을 다시 확인해주세요.", isRightButtonHidden: true, leftButtonTitle: "확인", isMessageLabelHidden: true)
                    default:
                        self?.showCustomAlert(alertType: .none, alertTitle: "조문 메세지 등록에 실패하셨습니다. 네트워크 연결을 확인해주세요.", isRightButtonHidden: true, leftButtonTitle: "확인", isMessageLabelHidden: true)
                    }
                }
            }
        }
    }
    //MARK: - Helpers
    private func setContribute() {
        titleLabel.text = "마지막 가시는길 \n조문 메세지를 전하세요."
        let now: String = {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let dateString = formatter.string(from: date)
            return dateString
        }()
        dateLabel.text = now
    }
}
