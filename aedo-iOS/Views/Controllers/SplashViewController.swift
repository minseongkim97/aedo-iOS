//
//  SplashViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/03/31.
//

import UIKit
import RealmSwift

class SplashViewController: UIViewController {
    //MARK: - Properties
    // Realm은 싱글톤 객체를 생성한다.
    let realm = try! Realm()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네트워크 연결 확인
        if NetworkMonitor.shared.isConnected {
            print("network connected \(String.init(describing: NetworkMonitor.ConnectionType.self))")
            // jailbreak 확인
            if UIDevice().isJailBroken {
                print("isJailBreak")
            } else {
                print("isNotJailBreak")
            }
        }
    }
    
    //MARK: - Actions
    
    //MARK: - Helpers
}
