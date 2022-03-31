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
    let verificationService = VerificationService()
    let policyService = PolicyService()
    
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
    private func writeAppPolicy(_ allPolicy: AllPolicy) {
        let appPolicy = AppPolicy()
        appPolicy._id = allPolicy.id
        appPolicy.result = allPolicy.result
        
        allPolicy.policy.forEach { polictEntity in
            let policy = Policy()
            policy.id = polictEntity.id
            policy.name = polictEntity.name
            policy.value = polictEntity.value
            appPolicy.policy.append(policy)
        }
        
        allPolicy.code.forEach { codeEntity in
            let code = Code()
            code.cd = codeEntity.cd
            code.name = codeEntity.name
            code.name_en = codeEntity.nameEn
            code.category_cd = codeEntity.categoryCd
            code.category_name = codeEntity.categoryName
            appPolicy.code.append(code)
        }
        
        allPolicy.appMenu.forEach { appMenuEntity in
            let appMenu = AppMenu()
            appMenu.cd = appMenuEntity.cd
            appMenu.name = appMenuEntity.name
            appMenu.name_en = appMenuEntity.nameEn
            appMenu.category_cd = appMenuEntity.categoryCd
            appMenu.category_name = appMenuEntity.categoryName
            appMenu.icon_name = appMenuEntity.iconName
            appMenu.use_yn = appMenuEntity.useYN
            appPolicy.app_menu.append(appMenu)
        }
        
        allPolicy.coordinates.forEach({ coordinateEntity in
            let coordinates = Coordinate()
            coordinates.id = coordinateEntity.id
            coordinates.name = coordinateEntity.name
            coordinates.xvalue = coordinateEntity.xvalue
            coordinates.yvalue = coordinateEntity.yvalue
            appPolicy.coordinates.append(coordinates)
        })
        
        do {
            try realm.write {
                realm.add(appPolicy)
            }
        } catch {
            print("realm write error")
            showSystemMaintenanceAlert()
        }
    }
    
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
        verificationService.getVerification { [weak self] result in
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
    
    private func managerPolicyData() {
        policyService.getPolicy { [weak self] result in
            switch result {
            case .success(let policy):
                DispatchQueue.main.async {
                    self?.writeAppPolicy(policy)
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
