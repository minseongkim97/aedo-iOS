//
//  PrivateInfoAccessViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/02.
//

import UIKit

class PrivateInfoAccessViewController: UIViewController {
    //MARK: - Properties
    static let identifier = "PrivateInfoAccessViewController"
    
    let termService = TermService()

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    @IBOutlet private weak var firstTermLabel: UILabel!
    @IBOutlet private weak var secondTermLabel: UILabel!
    @IBOutlet private weak var thirdTermLabel: UILabel!
    @IBOutlet private weak var fourthTermLabel: UILabel!
    @IBOutlet private weak var fifthTermLabel: UILabel!
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTerm()
    }
    //MARK: - Actions
    
    @IBAction func didTappedBackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: - Helpers
    private func getTerm() {
        termService.getTerm { [weak self] result in
            switch result {
            case .success(let term):
                DispatchQueue.main.async {
                    self?.titleLabel.text = term.title
                    self?.subTitleLabel.text = term.subTitle
                    self?.firstTermLabel.text = term.first
                    self?.secondTermLabel.text = term.second
                    self?.thirdTermLabel.text = term.third
                    self?.fourthTermLabel.text = term.fourth
                    self?.fifthTermLabel.text = term.fifth
                }
                
            default:
                DispatchQueue.main.async {
                    self?.showNetworkErrorAlert()
                }
               
            }
        }
    }
}
