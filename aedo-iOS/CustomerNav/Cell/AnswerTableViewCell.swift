//
//  AnswerTableViewCell.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/11.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {
    static let identifier = "AnswerTableViewCell"
    @IBOutlet weak var answerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
