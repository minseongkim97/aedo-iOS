//
//  MainMenuController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/03.
//

import UIKit

class MainSubMenuViewController: UIViewController {
    //MARK: - Properties
    static let identifier = "MainSubMenuViewController"
    let userInfoService = UserService()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserInfo()
    }
    
    //MARK: - Actions
    @IBAction func didTappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - Helpers
    private func getUserInfo() {
        userInfoService.getUserInfo { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.nameLabel.text = "\(response.user.name) 님,\n반갑습니다."
                    self.phoneNumberLabel.text = response.user.phone
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.showCustomAlert(alertType: .PopError, alertTitle: "회원 정보를 불러오는데 실패하였습니다.", isRightButtonHidden: true, leftButtonTitle: "확인")
                }
            }
        }
    }
}


