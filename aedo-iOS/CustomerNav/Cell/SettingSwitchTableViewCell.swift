//
//  SettingSwitchTableViewCell.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/14.
//

import UIKit

class SettingSwitchTableViewCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "SettingSwitchTableViewCell"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var settingSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        settingSwitch.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        settingSwitch.isOn = false
    }
    
    public func configure(with model: SettingSwitchOption) {
        titleLabel.text = model.title
        settingSwitch.isOn = model.isOn
    }
}
