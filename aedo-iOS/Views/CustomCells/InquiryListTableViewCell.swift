//
//  InquiryListTableViewCell.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/12.
//

import UIKit

class InquiryListTableViewCell: UITableViewCell {
    static let identifier = "InquiryListTableViewCell"
    var inquiry: Inquiry?
    
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
    @IBOutlet weak var inquiryTitleLabel: UILabel!
    @IBOutlet weak var inquiryCreatedDateLabel: UILabel!
    @IBOutlet weak var inquiryStateImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setInquiry(_ inquiry: Inquiry) {
        self.inquiry = inquiry
        inquiryTitleLabel.text = inquiry.title
        inquiryCreatedDateLabel.text = inquiry.created
    }

}
