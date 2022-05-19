//
//  MainMenuController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/03.
//

import UIKit
import SafariServices

class MainSubMenuViewController: UIViewController {
    //MARK: - Properties
    static let identifier = "MainSubMenuViewController"
    let userInfoService = UserService()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var kakaoTalkInquiryButton: BaseButton!
    @IBOutlet weak var personalInquiryButton: BaseButton!
    
    @IBOutlet weak var commonQuestionButton: BaseButton!
    @IBOutlet weak var phoneInquiryButton: BaseButton!
    @IBOutlet weak var useInfoStackView: UIStackView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserInfo()
        putGesture()
    }
    
    //MARK: - Actions
    @IBAction func didTappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTappedInquiryButton(_ sender: UIButton) {
        openSFSafariView("http://pf.kakao.com/_Xuvxeb/chat")
    }
    
    @IBAction func didTappedCommonQuestionButton(_ sender: UIButton) {
        let commonQuestionViewController = UIStoryboard(name: "CustomerNav", bundle: nil).instantiateViewController(identifier: CommonQuestionListViewController.identifier) as! CommonQuestionListViewController
        self.navigationController?.pushViewController(commonQuestionViewController, animated: true)
    }
    
    @IBAction func didTappedPhoneInquiryButton(_ sender: UIButton) {
        print("전화문의")
    }
    //MARK: - Selector
    @objc func didTappedStackView() {
        let useInfoVC = UIStoryboard(name: "MainNav", bundle: nil).instantiateViewController(identifier: UseInfoViewController.identifier) as! UseInfoViewController
        self.navigationController?.pushViewController(useInfoVC, animated: true)
    }

    //MARK: - Helpers
    private func openSFSafariView(_ targetURL: String) {
        guard let url = URL(string: targetURL) else { return }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.modalPresentationStyle = .automatic
        present(safariViewController, animated: true, completion: nil)
    }
    
    private func putGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTappedStackView))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        useInfoStackView.addGestureRecognizer(gesture)
    }

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
