//
//  CustomerNoticeListViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/05.
//

import UIKit

class CustomerNoticeListViewController: UIViewController {
    //MARK: - Properties
    static let identifier = "CustomerNoticeListViewController"
    let announcementListViewModel = AnnouncementListViewModel()
    
    @IBOutlet private weak var activity: UIActivityIndicatorView!
    @IBOutlet private weak var noticeListTableView: UITableView! {
        didSet {
            noticeListTableView.dataSource = self
            noticeListTableView.delegate = self
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        announcementListViewModel.loadingStarted = { [weak self] in
            self?.activity.isHidden = false
            self?.activity.startAnimating()
        }
        
        announcementListViewModel.loadingEnded = { [weak self] in
            self?.activity.stopAnimating()
        }
        
        announcementListViewModel.announcementListUpdated = { [weak self] in
                self?.noticeListTableView.reloadData()
        }
        
        announcementListViewModel.showNetworkErrorAlert = { [weak self] in
            self?.showNetworkErrorAlert()
        }
        
        announcementListViewModel.list()
    }
    
    //MARK: - Actions
    @IBAction func didTappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CustomerNoticeListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announcementListViewModel.announcementsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomerNoticeListTableViewCell.identifier, for: indexPath) as? CustomerNoticeListTableViewCell else { return UITableViewCell() }
        let notice = announcementListViewModel.announcement(at: indexPath.row)
        cell.setNotice(notice)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailNoticeVC = UIStoryboard(name: "CustomerNav", bundle: nil).instantiateViewController(identifier: NoticeDetailViewController.identifier) as? NoticeDetailViewController else { return }
        detailNoticeVC.noticeID = announcementListViewModel.announcement(at: indexPath.row).id
        
        self.navigationController?.pushViewController(detailNoticeVC, animated: true)
    }
}
