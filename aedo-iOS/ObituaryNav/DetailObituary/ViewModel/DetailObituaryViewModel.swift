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
    private let detailObituaryService: DetailObituaryServiceProtocol
    var detailObituaryList = BehaviorSubject<[ObituaryResponse]>(value: [])
    
    init(name: String, detailObituaryService: DetailObituaryServiceProtocol = DetailObituaryService()) {
        self.detailObituaryService = detailObituaryService
        reloadData(name: name)
    }

    func reloadData(name: String) {
        _ = self.detailObituaryService.fetchDetailObituaryList(name: name)
            .bind(to: detailObituaryList)
            .disposed(by: disposeBag)
    }
}
