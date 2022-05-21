//
//  SettingVersionTableViewCell.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/14.
//

import UIKit

class SettingVersionTableViewCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "SettingVersionTableViewCell"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        versionLabel.text = nil
    }
    
    public func configure(with model: SettingVersionOption) {
        titleLabel.text = model.title
        versionLabel.text = model.version
    }
}
