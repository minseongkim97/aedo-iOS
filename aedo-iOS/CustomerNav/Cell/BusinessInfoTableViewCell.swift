//
//  BusinessInfoTableViewCell.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/19.
//

import UIKit

class BusinessInfoTableViewCell: UITableViewCell {
    static let identifier = "BusinessInfoTableViewCell"
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        self.contentView.backgroundColor = .systemBackground
        contentLabel.font = UIFont(name: "NotoSansCJKkr-Bold", size: 16)
        contentLabel.textColor = .black
    }

}
