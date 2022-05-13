//
//  MainViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/01.
//

import UIKit

class MainViewController: UIViewController {
    //MARK: - Properties
    static let identifier = "MainViewController"
    let announcementListViewModel = AnnouncementListViewModel()
    
    @IBOutlet private weak var activity: UIActivityIndicatorView!
    @IBOutlet private weak var announcementView: UIView!
//        didSet {
//            announcementView.layer.shadowPath = UIBezierPath(roundedRect: announcementView.bounds, cornerRadius: announcementView.layer.cornerRadius).cgPath
//        }
//    }
    @IBOutlet private weak var announcementTableView: UITableView! {
        didSet {
            announcementTableView.delegate = self
            announcementTableView.dataSource = self
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        announcementListViewModel.loadingStarted = { [weak self] in
            self?.activity.isHidden = false
            self?.activity.startAnimating()
        }
        
        announcementListViewModel.loadingEnded = { [weak self] in
            self?.activity.stopAnimating()
        }
        
        announcementListViewModel.announcementListUpdated = { [weak self] in
            self?.announcementTableView.reloadData()
        }
        
        announcementListViewModel.showNetworkErrorAlert = { [weak self] in
            self?.showNetworkErrorAlert()
        }
        
        announcementListViewModel.list()
    }
    //MARK: - Actions
    @IBAction func didTappedMenuButton(_ sender: UIButton) {
        let mainSubMenuViewController = UIStoryboard(name: "MainNav", bundle: nil).instantiateViewController(identifier: MainSubMenuViewController.identifier)
        self.navigationController?.pushViewController(mainSubMenuViewController, animated: true)
    }
    
    @IBAction func didTappedRegisterObituaryButton(_ sender: UIButton) {
        let registerObituaryViewController = UIStoryboard(name: "ObituaryListNav", bundle: nil).instantiateViewController(identifier: RegisterObituaryViewController.identifier)
        self.navigationController?.pushViewController(registerObituaryViewController, animated: true)
    }
    
    @IBAction func didTappedMoreAnnouncementButton(_ sender: UIButton) {
        let customerNoticeListViewController = UIStoryboard(name: "CustomerNav", bundle: nil).instantiateViewController(identifier: CustomerNoticeListViewController.identifier)
        self.navigationController?.pushViewController(customerNoticeListViewController, animated: true)
    }
    
    //MARK: - Helpers
    private func setUI() {
        announcementView.layer.cornerRadius = 10
        announcementView.layer.shadowOpacity = 0.25
        announcementView.layer.shadowColor = UIColor.black.cgColor
        announcementView.layer.shadowOffset = CGSize(width: 4, height: 15)
        announcementView.layer.shadowRadius = 10
//        announcementView.layer.shadowPath = UIBezierPath(roundedRect: announcementView.bounds, cornerRadius: announcementView.layer.cornerRadius).cgPath
        announcementView.layer.masksToBounds = false
    }
}

//MARK: - Extension
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announcementListViewModel.announcementsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnnouncementTableViewCell.identifier, for: indexPath) as? AnnouncementTableViewCell else { return UITableViewCell() }
        
        let announcement = announcementListViewModel.announcement(at: indexPath.row)
        cell.setAnnouncement(announcement)

        return cell
    }
}
