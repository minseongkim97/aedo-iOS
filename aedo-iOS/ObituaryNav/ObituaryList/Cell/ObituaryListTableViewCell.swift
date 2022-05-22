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
    var obID: String = ""
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var sendObituaryButton: UIButton! {
        didSet {
            sendObituaryButton.addTarget(self, action: #selector(didTappedSendObituary(_:)), for: .touchUpInside)
        }
    }
    @IBOutlet weak var seeObituaryButton: UIButton! {
        didSet {
            seeObituaryButton.addTarget(self, action: #selector(didTappedShowDetailObituary), for: .touchUpInside)
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var residentLabel: UILabel!
    @IBOutlet weak var funeralNameLabel: UILabel!
    
    var disposeBag = DisposeBag()
    var showDetailObituaryButtonAction: (() -> Void)?
    var sendObituaryButtonAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setAttribute()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    //MARK: - Actions
    @objc func didTappedSendObituary(_ sender: UIButton) {
        sendObituaryButtonAction?()
    }
    
    @objc func didTappedShowDetailObituary(_ sender: UIButton) {
        showDetailObituaryButtonAction?()
    }

    //MARK: - Helpers
    func updateUI(item: ObituaryResponse) {
        obID = item.id
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
