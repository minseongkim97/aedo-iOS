//
//  CustomerNoticeListTableViewCell.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/05.
//

import UIKit

class CustomerNoticeListTableViewCell: UITableViewCell {
    static let identifier: String = "CustomerNoticeListTableViewCell"
    var notice: Announcement?
    
    @IBOutlet weak var cellContentView: UIView! {
        didSet {
            cellContentView.layer.borderWidth = 1
            cellContentView.layer.borderColor = UIColor(hex: 0xDDDDDD).cgColor
            cellContentView.layer.cornerRadius = 10
            cellContentView.layer.shadowOpacity = 0.05
            cellContentView.layer.shadowRadius = 10
            cellContentView.layer.shadowColor = UIColor.black.cgColor
            cellContentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        }
    }
    @IBOutlet weak var noticeTitleLabel: UILabel!
    @IBOutlet weak var noticeDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }


    func setNotice(_ notice: Announcement) {
        self.notice = notice
        noticeTitleLabel.text = notice.title
        noticeDateLabel.text = notice.created
    }
}
