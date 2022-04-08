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
    @IBOutlet private weak var announcementView: UIView! {
        didSet {
            announcementView.layer.shadowPath = UIBezierPath(roundedRect: announcementView.bounds, cornerRadius: announcementView.layer.cornerRadius).cgPath
        }
    }
    @IBOutlet private weak var announcementTableView: UITableView! {
        didSet {
            announcementTableView.delegate = self
            announcementTableView.dataSource = self
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        announcementListViewModel.loadingStarted = { [weak self] in
            print("loading start")
            self?.activity.isHidden = false
            self?.activity.startAnimating()
        }
        
        announcementListViewModel.loadingEnded = { [weak self] in
            self?.activity.stopAnimating()
        }
        
        announcementListViewModel.announcementListUpdated = { [weak self] in
                self?.announcementTableView.reloadData()
        }
        
        announcementListViewModel.list()
    }
    //MARK: - Actions
    @IBAction func didTappedMenuButton(_ sender: UIButton) {
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
