//
//  OrderListTableViewCell.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/06/30.
//

import UIKit

class OrderListTableViewCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "OrderListTableViewCell"
    
    @IBOutlet weak var cellContentView: UIView! {
        didSet {
            cellContentView.layer.borderWidth = 1
            cellContentView.layer.borderColor = UIColor(hex: 0xDDDDDD).cgColor
            cellContentView.layer.cornerRadius = 10
            cellContentView.layer.shadowOpacity = 0.05
            cellContentView.layer.shadowRadius = 10
            cellContentView.layer.shadowColor = UIColor.black.cgColor
            cellContentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        }
    }
    @IBOutlet weak var orderNameAndPriceLabel: UILabel!
    @IBOutlet weak var presidentNameLabel: UILabel!
    @IBOutlet weak var senderNameLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    
    //MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - Action
    @IBAction func didTappedRightArrowButton(_ sender: UIButton) {
    }
}
