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
    
    private var noticeList = [Announcement]() {
        didSet {
            DispatchQueue.main.async {
                self.noticeListTableView.reloadData()
            }
        }
    }
    @IBOutlet private weak var noticeListTableView: UITableView! {
        didSet {
            noticeListTableView.dataSource = self
            noticeListTableView.delegate = self
        }
    }
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK: - Actions
    
    //MARK: - Helpers
}

extension CustomerNoticeListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomerNoticeListTableViewCell.identifier, for: indexPath) as? CustomerNoticeListTableViewCell else { return UITableViewCell() }
        
        cell.noticeTitleLabel.text = noticeList[indexPath.row].title
        cell.noticeDateLabel.text = noticeList[indexPath.row].created
        
        return cell
    }
}
