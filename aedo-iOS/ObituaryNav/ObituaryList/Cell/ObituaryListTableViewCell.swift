//
//  ObituaryListTableViewCell.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/17.
//

import UIKit
import RxSwift

class ObituaryListTableViewCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "ObituaryListTableViewCell"
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var sendObituaryButton: UIButton!
    @IBOutlet weak var seeObituaryButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var residentLabel: UILabel!
    @IBOutlet weak var funeralNameLabel: UILabel!
    
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setAttribute()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func updateUI(item: ObituaryResponse) {
        nameLabel.text = item.deceased.name
        dateLabel.text = item.created
        residentLabel.text = item.resident.name
        funeralNameLabel.text = item.place
    }
    
    private func setAttribute() {
        containerView.layer.borderWidth = 0.5
        containerView.layer.borderColor = UIColor(hex: 0xDDDDDD).cgColor
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        containerView.layer.shadowRadius = 10
        containerView.layer.masksToBounds = false
        
        sendObituaryButton.layer.cornerRadius = 10
        sendObituaryButton.layer.masksToBounds = true
        
        seeObituaryButton.layer.cornerRadius = 10
        seeObituaryButton.layer.masksToBounds = true
    }
}
