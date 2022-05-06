//
//  ObituaryListViewModel.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/02.
//

import Foundation
import RxSwift
import RxRelay

final class ObituaryListViewModel {
    private let obituaryListService = ObituaryListService()
    var obituaryList = BehaviorSubject<[ObituaryResponse]>(value: [])

    init(name: String) {
        reloadData()
    }

    func reloadData() {
        _ = obituaryListService.fetchObituaryList()
            .bind(to: obituaryList)
    }
}
