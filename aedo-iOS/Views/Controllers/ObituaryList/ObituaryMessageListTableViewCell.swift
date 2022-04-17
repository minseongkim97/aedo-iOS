//
//  ObituaryMessageListTableViewCell.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/18.
//

import UIKit

class ObituaryMessageListTableViewCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "ObituaryMessageListTableViewCell"
    
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
