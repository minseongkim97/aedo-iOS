//
//  SettingStaticTableViewCell.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/14.
//

import UIKit

class SettingStaticTableViewCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "SettingStaticTableViewCell"
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with model: SettingsOption) {
        titleLabel.text = model.title
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
    }
}
