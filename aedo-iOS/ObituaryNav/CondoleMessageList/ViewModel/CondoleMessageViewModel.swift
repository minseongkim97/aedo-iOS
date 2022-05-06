//
//  CondoleMessageViewModel.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/07.
//

import Foundation
import RxSwift
import RxRelay

struct CondoleMessageViewModel {
    private let condole: CondoleMessage
    
    var titleText: String {
        return condole.title
    }
    
    var dateText: String {
        return condole.created
    }
    
    var senderText: String {
        return "from. \(condole.content)"
    }
    
    init(condole: CondoleMessage) {
        self.condole = condole
    }
}
