//
//  CommonQuestionTableViewCell.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/11.
//

import UIKit

class CommonQuestionTableViewCell: UITableViewCell {
    static let identifier = "CommonQuestionTableViewCell"
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var chevronImageView: UIImageView!
    @IBOutlet weak var separateLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
