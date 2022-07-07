//
//  FirstCell.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/06/28.
//

import UIKit

class FirstCell: UITableViewCell {
        
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.borderWidth = 0.5
            containerView.layer.borderColor = UIColor(hex: 0xDDDDDD).cgColor
            containerView.layer.cornerRadius = 10
            containerView.layer.shadowOpacity = 0.15
            containerView.layer.shadowRadius = 3
            containerView.layer.shadowColor = UIColor.black.cgColor
            containerView.layer.shadowOffset = CGSize(width: 2, height: 2)
        }
    }
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var orderView: UIView! {
        didSet {
            orderView.layer.borderColor = UIColor(hex: 0xDDDDDD).cgColor
            orderView.layer.borderWidth = 0.5
            orderView.layer.cornerRadius = 5.0
            orderView.layer.shadowColor = UIColor.black.cgColor
            orderView.layer.shadowOpacity = 0.15
            orderView.layer.shadowRadius = 3.0
            orderView.layer.shadowOffset = CGSize(width: 2, height: 2)
        }
    }
    @IBOutlet weak var starImgView: UIImageView!
    @IBOutlet weak var bestLabel: UILabel!
    var tapAction: (() -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))

            orderView.addGestureRecognizer(tapGesture)
      }

      @objc func handleTap(sender: UITapGestureRecognizer) {
          tapAction?()
    }
    
    

}
