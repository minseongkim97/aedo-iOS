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
    
    let announcementService = AnnouncementService()
    private var announcement = [Announcement]()
    
    @IBOutlet private weak var announcementTableView: UITableView! {
        didSet {
            announcementTableView.delegate = self
            announcementTableView.dataSource = self
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllAnnouncement()
        
    }
    //MARK: - Actions
    
    //MARK: - Helpers
    private func getAllAnnouncement() {
        announcementService.getAllAnnouncement { [weak self] result in
            switch result {
            case .success(let response):
                self?.announcement = response.result
            default:
                DispatchQueue.main.async {
                    self?.showNetworkErrorAlert()
                }
            }
        }
    }
}

//MARK: - Extension
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnnouncementTableViewCell.identifier, for: indexPath) as? AnnouncementTableViewCell else { return UITableViewCell() }
        
        cell.announcementTilteLabel.text = announcement[indexPath.row].title
        cell.announcementCreatedDateLabel.text = announcement[indexPath.row].created
        
        
        return cell
    }
    
    
}
