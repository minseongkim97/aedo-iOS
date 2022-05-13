//
//  NoticeDetailViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/08.
//

import UIKit

class NoticeDetailViewController: UIViewController {
    //MARK: - Properties
    static let identifier = "NoticeDetailViewController"
    let announcementService = AnnouncementService()
    var noticeID = ""
    
    @IBOutlet private weak var noticeView: UIView!
    @IBOutlet private weak var noticeTitleLabel: UILabel!
    @IBOutlet private weak var noticeCreatedDateLabel: UILabel!
    @IBOutlet weak var noticeContentLabel: UILabel!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setContribute()
        getDetailNotice()
    }
    
    //MARK: - Actions
    @IBAction func didTappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helpers
    private func getDetailNotice() {
        announcementService.getDetailAnnouncement(id: noticeID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.noticeTitleLabel.text = response.announcement.title
                    self.noticeCreatedDateLabel.text = response.announcement.created
                    self.noticeContentLabel.text = response.announcement.content
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.showCustomAlert(alertType: .PopError, alertTitle: "상세 공지를 확인할 수 없습니다.", isRightButtonHidden: true, leftButtonTitle: "확인")
                }
            }
        }
    }
    
    private func setContribute() {
        noticeView.layer.borderWidth = 0.5
        noticeView.layer.borderColor = UIColor(hex: 0xDDDDDD).cgColor
        noticeView.layer.cornerRadius = 10
        noticeView.layer.shadowOpacity = 0.05
        noticeView.layer.shadowColor = UIColor.black.cgColor
        noticeView.layer.shadowOffset = CGSize(width: 0, height: 10)
        noticeView.layer.shadowRadius = 10
        noticeView.layer.masksToBounds = false
    }
}
