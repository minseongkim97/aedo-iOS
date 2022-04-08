//
//  AnnouncementTableViewCell.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/02.
//

import UIKit

class AnnouncementTableViewCell: UITableViewCell {
    static var identifier: String = "AnnounceTableViewCell"
    var announcement: Announcement?

    @IBOutlet weak var announcementTilteLabel: UILabel!
    @IBOutlet weak var announcementCreatedDateLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setAnnouncement(_ announcement: Announcement) {
        self.announcement = announcement
        announcementTilteLabel.text = announcement.title
        announcementCreatedDateLabel.text = announcement.created
    }

}
