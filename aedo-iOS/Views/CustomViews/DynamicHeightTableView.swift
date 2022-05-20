//
//  DynamicHeightTableVIEW.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/19.
//

import UIKit

class DynamicHeightTableView: UITableView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.invalidateIntrinsicContentSize()
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
