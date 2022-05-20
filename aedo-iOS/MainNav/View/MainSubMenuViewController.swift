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
    @IBOutlet weak var businessmanInfoStackView: UIStackView!
    @IBOutlet weak var obituaryListStackView: UIStackView!
    @IBOutlet weak var orderListStackView: UIStackView!
    @IBOutlet weak var thanksToCondoleMessageStackView: UIStackView!
    
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
    
    @IBAction func didTappedPhoneInquiryButton(_ sender: UIButton) {
        let number:Int = 1028320516
                
        // URLScheme 문자열을 통해 URL 인스턴스를 만들어 줍니다.
        if let url = NSURL(string: "tel://0" + "\(number)"),
        
           //canOpenURL(_:) 메소드를 통해서 URL 체계를 처리하는 데 앱을 사용할 수 있는지 여부를 확인
           UIApplication.shared.canOpenURL(url as URL) {
           
           //사용가능한 URLScheme이라면 open(_:options:completionHandler:) 메소드를 호출해서
           //만들어둔 URL 인스턴스를 열어줍니다.
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func didTappedCommonQuestionButton(_ sender: UIButton) {
        let commonQuestionViewController = UIStoryboard(name: "CustomerNav", bundle: nil).instantiateViewController(identifier: CommonQuestionListViewController.identifier) as! CommonQuestionListViewController
        self.navigationController?.pushViewController(commonQuestionViewController, animated: true)
    }
    
    //MARK: - Selector
    @objc func didTappedUseInfoStackView() {
        let useInfoVC = UIStoryboard(name: "MainNav", bundle: nil).instantiateViewController(identifier: UseInfoViewController.identifier) as! UseInfoViewController
        self.navigationController?.pushViewController(useInfoVC, animated: true)
    }
    
    @objc func didTappedObituaryListStackView() {
        let obituaryListVC = UIStoryboard(name: "ObituaryListNav", bundle: nil).instantiateViewController(identifier: ObituaryListViewController.identifier) as! ObituaryListViewController
        self.navigationController?.pushViewController(obituaryListVC, animated: true)
    }
    
    @objc func didTappedBusinessmanInfoStackView() {
        let businessmanInfoVC = UIStoryboard(name: "CustomerNav", bundle: nil).instantiateViewController(identifier: BusinessmanInfoViewController.identifier) as! BusinessmanInfoViewController
        self.navigationController?.pushViewController(businessmanInfoVC, animated: true)
    }
    
    @objc func didTappedOrderListStackView() {
    }
    
    @objc func didTappedThanksToCondoleMessageStackView() {
        let thanksToCondoleMessageVC = UIStoryboard(name: "CustomerNav", bundle: nil).instantiateViewController(identifier: ThanksToCondoleMessageViewController.identifier) as! ThanksToCondoleMessageViewController
        self.navigationController?.pushViewController(thanksToCondoleMessageVC, animated: true)
    }

    //MARK: - Helpers
    private func putGesture() {
        let useInfoStackGesture = UITapGestureRecognizer(target: self, action: #selector(didTappedUseInfoStackView))
        useInfoStackGesture.numberOfTapsRequired = 1
        useInfoStackGesture.numberOfTouchesRequired = 1
        useInfoStackView.addGestureRecognizer(useInfoStackGesture)
        
        let obituaryListStackGesture = UITapGestureRecognizer(target: self, action: #selector(didTappedObituaryListStackView))
        obituaryListStackGesture.numberOfTapsRequired = 1
        obituaryListStackGesture.numberOfTouchesRequired = 1
        obituaryListStackView.addGestureRecognizer(obituaryListStackGesture)
        
        let businessmanInfoStackGesture = UITapGestureRecognizer(target: self, action: #selector(didTappedBusinessmanInfoStackView))
        businessmanInfoStackGesture.numberOfTapsRequired = 1
        businessmanInfoStackGesture.numberOfTouchesRequired = 1
        businessmanInfoStackView.addGestureRecognizer(businessmanInfoStackGesture)
        
        let orderListStackGesture = UITapGestureRecognizer(target: self, action: #selector(didTappedOrderListStackView))
        orderListStackGesture.numberOfTapsRequired = 1
        orderListStackGesture.numberOfTouchesRequired = 1
        orderListStackView.addGestureRecognizer(orderListStackGesture)
        
        let thanksToCondoleMessageStackGesture = UITapGestureRecognizer(target: self, action: #selector(didTappedThanksToCondoleMessageStackView))
        thanksToCondoleMessageStackGesture.numberOfTapsRequired = 1
        thanksToCondoleMessageStackGesture.numberOfTouchesRequired = 1
        thanksToCondoleMessageStackView.addGestureRecognizer(thanksToCondoleMessageStackGesture)
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
