//
//  DetailObituaryViewModel.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/08.
//

import Foundation
import RxSwift
import RxRelay

final class DetailObituaryViewModel {
    private let disposeBag = DisposeBag()
    private let detailObituaryService = DetailObituaryService()
    private let condoleMessageListService = CondoleMessageListService()
    var detailObituaryList = BehaviorSubject<[ObituaryResponse]>(value: [])
    var condoleMessageList = BehaviorRelay<[CondoleMessageViewModel]>(value: [])
    
    init(name: String, obID: String) {
        reloadData(name: name, obID: obID)
    }

    func reloadData(name: String, obID: String) {
        _ = self.detailObituaryService.fetchDetailObituaryList(name: name)
            .bind(to: detailObituaryList)
            .disposed(by: disposeBag)
        _ = self.fetchCondoleListViewModel(of: obID)
            .bind(to: condoleMessageList)
            .disposed(by: disposeBag)
    }
    
    private func fetchCondoleListViewModel(of obID: String) -> Observable<[CondoleMessageViewModel]> {
        condoleMessageListService.fetchCondoleMessageList(of: obID).map {
            $0.map {
                CondoleMessageViewModel(condole: $0)
            }
        }
    }
}
