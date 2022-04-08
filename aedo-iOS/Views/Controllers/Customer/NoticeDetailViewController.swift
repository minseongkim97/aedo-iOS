//
//  NoticeDetailViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/08.
//

import UIKit

class NoticeDetailViewController: UIViewController {
    //MARK: - Properties
    @IBOutlet private weak var noticeView: UIView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    //MARK: - Helpers
    private func setUI() {
        noticeView.layer.borderWidth = 0.5
        noticeView.layer.borderColor = UIColor(hex: 0xDDDDDD).cgColor
        noticeView.layer.cornerRadius = 10
        noticeView.layer.shadowOpacity = 0.05
        noticeView.layer.shadowColor = UIColor.black.cgColor
        noticeView.layer.shadowOffset = CGSize(width: 0, height: 10)
        noticeView.layer.shadowRadius = 10
        noticeView.layer.shadowPath = UIBezierPath(roundedRect: noticeView.bounds, cornerRadius: noticeView.layer.cornerRadius).cgPath
        noticeView.layer.masksToBounds = false
    }
}
