//
//  MenuCell.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/06/27.
//

import UIKit
import PagingKit

class MenuCell: PagingMenuViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override public var isSelected: Bool {
       didSet {
           if isSelected {
               titleLabel.textColor = .black
           } else {
               titleLabel.textColor = UIColor.pointOrange
           }
       }
    }
}
