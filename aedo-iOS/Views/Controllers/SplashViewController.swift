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
    let verificationDataService = VerificationDataService()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네트워크 연결 확인
        if NetworkMonitor.shared.isConnected {
            print("network connected \(String.init(describing: NetworkMonitor.ConnectionType.self))")
            // jailbreak 확인
            if UIDevice().isJailBroken {
                print("isJailBreak")
                showSystemMaintenanceAlert()
            } else {
                print("isNotJailBreak")
                managerVerficationData()
            }
        } else { // 네트워크 연결 실패
            showNetworkErrorAlert()
        }
    }
    
    //MARK: - Actions
    
    //MARK: - Helpers
    private func writeAppVerification(_ appVerfication: Verification) {
        let verification = AppVerification()
        verification.result = appVerfication.result
        verification._id = appVerfication.id
        

        appVerfication.appToken.forEach { token in
            let appToken = AppToken()
            appToken.appToken = token.appToken
            verification.app_token.append(appToken)
        }

        appVerfication.encrypt.forEach { encryptEntity in
            let encrypt = Encrypt()
            encrypt.key = encryptEntity.key
            encrypt.iv = encryptEntity.iv
            verification.encrypt.append(encrypt)
        }

        appVerfication.policyVer.forEach { policyVerEntity in
            let policyVer = PolicyVer()
            policyVer.version = policyVerEntity.version
            verification.policy_ver.append(policyVer)
        }

        do {
            try realm.write {
                realm.add(verification)
            }
        } catch {
            print("realm write error")
            showSystemMaintenanceAlert()
        }
    }
    
    private func managerVerficationData() {
        verificationDataService.getVerification { [weak self] result in
            switch result {
            case .success(let verification):
                DispatchQueue.main.async {
                    self?.writeAppVerification(verification)
                }
                
            case .failure(.invalidURL), .failure(.unableToComplete), .failure(.invalidResponse), .failure(.invalidData):
                print("get verfication data is failed")
                DispatchQueue.main.async {
                    self?.showSystemMaintenanceAlert()
                }
            }
        }
    }
}
