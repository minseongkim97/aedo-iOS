//
//  AnnouncementListViewModel.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/08.
//

import Foundation

class AnnouncementListViewModel {
    let announcementService = AnnouncementService()
    
    private var announcementList = AnnouncementList.EMPTY
    private var loading = false
    
    var loadingStarted: () -> Void = {}
    var loadingEnded: () -> Void = {}
    var announcementListUpdated: () -> Void = {}
    var showNetworkErrorAlert: () -> Void = {}
    
    func announcementsCount() -> Int {
        return announcementList.announcement.count
    }
    
    func announcement(at index: Int) -> Announcement {
        return announcementList.announcement[index]
    }
    
    func list() {
        loading = true
        loadingStarted()
        announcementService.getAllAnnouncement { [weak self] result in
            switch result {
            case .success(let response):
                self?.announcementList = response
                DispatchQueue.main.async {
                    self?.announcementListUpdated()
                    self?.loadingEnded()
                    self?.loading = false
                }
                
            default:
                DispatchQueue.main.async {
                    self?.showNetworkErrorAlert()
                }
            }
        }
    }
    
    
}
