//
//  UseInfoViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/19.
//

import UIKit

class UseInfoViewController: UIViewController {
    //MARK: - Properties
    static let identifier = "UseInfoViewController"
    @IBOutlet weak var useInfoImageView: UIImageView!
    @IBOutlet weak var useInfoImageHeightConstraint: NSLayoutConstraint!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    //MARK: - Actions
    @IBAction func didTappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helpers
    private func setUI() {
        useInfoImageHeightConstraint.constant = self.view.bounds.width * 8198 / 1439
        self.view.layoutIfNeeded()
    }
}
