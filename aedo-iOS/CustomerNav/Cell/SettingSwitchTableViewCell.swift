//
//  SettingSwitchTableViewCell.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/14.
//

import UIKit
import UserNotifications

enum Switch: Int {
    case autoLogin
    case alarm
}

class SettingSwitchTableViewCell: UITableViewCell, UNUserNotificationCenterDelegate {
    //MARK: - Properties
    static let identifier = "SettingSwitchTableViewCell"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var settingSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        settingSwitch.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        UNUserNotificationCenter.current().delegate = self
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        switch sender.tag {
        case 0:
            UserDefaults.standard.set(sender.isOn, forKey: "autoLogin")
        case 1:
            UserDefaults.standard.set(sender.isOn, forKey: "alarm")
//            requestPushAlarm()
        default:
            break
        }
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
        self.selectionStyle = .none
        titleLabel.text = model.title
        if model.kind == .autoLogin {
            settingSwitch.isOn = UserDefaults.standard.bool(forKey: "autoLogin")
        } else if model.kind == .alarm {
            settingSwitch.isOn = UserDefaults.standard.bool(forKey: "alarm")
        }
        
        settingSwitch.tag = model.kind.rawValue
    }
    
    private func requestPushAlarm() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            print("Permission granted: \(granted)")
        }
    }
}
