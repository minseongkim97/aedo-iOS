//
//  OrderInfoViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/06/28.
//

import UIKit

class OrderAnnounceViewController: UIViewController {
    //MARK: - Properties
    static let identifier = "OrderAnnounceViewController"
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Action
    @IBAction func didTappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
