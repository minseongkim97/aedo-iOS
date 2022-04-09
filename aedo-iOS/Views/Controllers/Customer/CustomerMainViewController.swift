//
//  CustomerMainViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/05.
//

import UIKit

class CustomerMainViewController: UIViewController {
    //MARK: - Properties
    static let identifier = "CustomerMainViewController"

    @IBOutlet private weak var customerCenterVeiw: UIView!
    @IBOutlet private weak var customerServicesStackView: UIStackView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    //MARK: - Actions
    
    //MARK: - Helpers
    private func setUI() {
        customerCenterVeiw.layer.cornerRadius = 10
        customerCenterVeiw.layer.shadowOpacity = 0.1
        customerCenterVeiw.layer.shadowColor = UIColor.black.cgColor
        customerCenterVeiw.layer.shadowOffset = CGSize(width: 0, height: 10)
        customerCenterVeiw.layer.shadowRadius = 10
        customerCenterVeiw.layer.shadowPath = UIBezierPath(roundedRect: customerCenterVeiw.bounds, cornerRadius: customerCenterVeiw.layer.cornerRadius).cgPath
        customerCenterVeiw.layer.masksToBounds = false
        
        customerServicesStackView.layer.cornerRadius = 10
        customerServicesStackView.layer.shadowOpacity = 0.1
        customerServicesStackView.layer.shadowColor = UIColor.black.cgColor
        customerServicesStackView.layer.shadowOffset = CGSize(width: 0, height: 25)
        customerServicesStackView.layer.shadowRadius = 10
        customerServicesStackView.layer.shadowPath = UIBezierPath(roundedRect: customerServicesStackView.bounds, cornerRadius: customerServicesStackView.layer.cornerRadius).cgPath
        customerServicesStackView.layer.masksToBounds = false
    }
}

//MARK: - Extension
