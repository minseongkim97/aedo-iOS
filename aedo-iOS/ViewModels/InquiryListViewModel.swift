//
//  InquiryListViewModel.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/12.
//

import Foundation

class InquiryListViewModel {
    let inquiryServcie = InquiryService()
    
    private var inquiryList = InquiryList.EMPTY()
    private var loading = false
    
    var loadingStarted: () -> Void = {}
    var loadingEnded: () -> Void = {}
    var inquiryListUpdated: () -> Void = {}
    var showNetworkErrorAlert: () -> Void = {}
    
    func inquiriesCount() -> Int {
        return inquiryList.userRequest.count
    }
    
    func inquiry(at index: Int) -> Inquiry {
        return inquiryList.userRequest[index]
    }
    
    
    func list() {
        loading = true
        loadingStarted()
        inquiryServcie.getInquiryList { [weak self] result in
            switch result {
            case .success(let response):
                self?.inquiryList = response
                DispatchQueue.main.async {
                    self?.inquiryListUpdated()
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
