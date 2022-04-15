//
//  DetailInquiryViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/14.
//

import UIKit

class DetailInquiryViewController: UIViewController {
    //MARK: - Properties
    static let identifier = "DetailInquiryViewController"
    @IBOutlet private weak var answerView: UIView!
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setAnswerView()
    }
    
    //MARK: - Helpers
    private func setAnswerView() {
        answerView.layer.borderWidth = 1
        answerView.layer.borderColor = UIColor(hex: 0xDDDDDD).cgColor
        answerView.layer.cornerRadius = 10
    }
}
