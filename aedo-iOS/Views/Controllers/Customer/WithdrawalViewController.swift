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
    @IBOutlet private weak var noticeView: UIView!
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setNoticeView()
    }
    
    //MARK: - Helpers
    private func setNoticeView() {
        noticeView.layer.borderWidth = 1
        noticeView.layer.borderColor = UIColor(hex: 0xDDDDDD).cgColor
        noticeView.layer.cornerRadius = 10
    }
}
