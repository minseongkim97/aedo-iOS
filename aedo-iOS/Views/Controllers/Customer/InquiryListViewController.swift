//
//  InquiryListViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/12.
//

import UIKit

class InquiryListViewController: UIViewController {
    //MARK: - Properties
    static let identifier = "InquiryListViewController"
    let inquiryListViewModel = InquiryListViewModel()
    @IBOutlet weak var inquiryListTableView: UITableView! {
        didSet {
            inquiryListTableView.delegate = self
            inquiryListTableView.dataSource = self
        }
    }
    @IBOutlet private weak var activity: UIActivityIndicatorView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        inquiryListViewModel.loadingStarted = { [weak self] in
            self?.activity.isHidden = false
            self?.activity.startAnimating()
        }
        
        inquiryListViewModel.loadingEnded = { [weak self] in
            self?.activity.stopAnimating()
        }
        
        inquiryListViewModel.inquiryListUpdated = { [weak self] in
                self?.inquiryListTableView.reloadData()
        }
        
        inquiryListViewModel.showNetworkErrorAlert = { [weak self] in
            self?.showNetworkErrorAlert()
        }
        
        inquiryListViewModel.list()
    }
}

//MARK: - Extension: UITableViewDelegate
extension InquiryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inquiryListViewModel.inquiriesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InquiryListTableViewCell.identifier, for: indexPath) as? InquiryListTableViewCell else { return UITableViewCell() }
        let inquiry = inquiryListViewModel.inquiry(at: indexPath.row)
        cell.setInquiry(inquiry)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
