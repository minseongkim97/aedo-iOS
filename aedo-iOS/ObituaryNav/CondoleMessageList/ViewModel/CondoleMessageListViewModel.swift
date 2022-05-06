//
//  CondoleMessageListViewModel.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/06.
//

import Foundation
import RxSwift
import RxCocoa

final class CondoleMessageListViewModel {
    private let disposeBag = DisposeBag()
    private let condoleMessageListService: CondoleMessageListServiceProtocol
    var condoleMessageList = BehaviorRelay<[CondoleMessageViewModel]>(value: [])
    
    init(obID: String, condoleMessageListService: CondoleMessageListServiceProtocol = CondoleMessageListService()) {
        self.condoleMessageListService = condoleMessageListService
        reloadData(of: obID)
    }
    
    private func fetchCondoleListViewModel(of obID: String) -> Observable<[CondoleMessageViewModel]> {
        condoleMessageListService.fetchCondoleMessageList(of: obID).map {
            $0.map {
                CondoleMessageViewModel(condole: $0)
            }
        }
    }

    func reloadData(of obId: String) {
        _ = self.fetchCondoleListViewModel(of: obId)
            .bind(to: condoleMessageList)
            .disposed(by: disposeBag)
    }
}

