//
//  ObituaryMessageListTableViewCell.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/18.
//

import UIKit
import RxSwift

class CondoleMessageListTableViewCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "CondoleMessageListTableViewCell"
    
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
