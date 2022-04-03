//
//  AnnouncementTableViewCell.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/02.
//

import UIKit

class AnnouncementTableViewCell: UITableViewCell {
    static var identifier: String = "AnnounceTableViewCell"

    @IBOutlet private weak var announcementTilteLabel: UILabel!
    @IBOutlet private weak var announcementCreatedDateLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
