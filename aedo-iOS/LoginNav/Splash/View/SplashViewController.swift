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
    let autoLogInService = AutoLogInService()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 네트워크 연결 확인
        if NetworkMonitor.shared.isConnected {
            print("network connected")
            // jailbreak 확인
            if UIDevice().isJailBroken {
                print("isJailBreak")
                showSystemMaintenanceAlert()
            } else {
                print("isNotJailBreak")
                manageVerficationService()
            }
        } else { // 네트워크 연결 실패
            showNetworkErrorAlert()
        }
    }
    
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
            showSystemMaintenanceAlert()
        }
    }
    
    private func writeAppVerification(_ appVerfication: Verification) {
        managePolicyService()
        
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
    
    private func manageVerficationService() {
        verificationService.getVerification { [weak self] result in
            switch result {
            case .success(let verification):
                DispatchQueue.main.async {
                    self?.writeAppVerification(verification)
                }
                
            default:
                print("get verfication data is failed")
                DispatchQueue.main.async {
                    self?.showSystemMaintenanceAlert()
                }
            }
        }
    }
    
    private func managePolicyService() {
        policyService.getPolicy { [weak self] result in
            switch result {
            case .success(let policy):
                DispatchQueue.main.async {
                    self?.writeAppPolicy(policy)
                    self?.checkAppVersion()
                }
                
            default:
                print("get policy data is failed")
                DispatchQueue.main.async {
                    self?.showSystemMaintenanceAlert()
                }
            }
        }
    }
    
    private func requestAutoLogIn() {
        autoLogInService.autoLogIn { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    AccessToken.autoLogInAccessToken = response.accessToken
                    let mainViewController = UIStoryboard(name: "MainNav", bundle: nil).instantiateViewController(identifier: MainViewController.identifier) 
                    let navVC = UINavigationController(rootViewController: mainViewController)
                    navVC.isNavigationBarHidden = true
                    self?.changeRootViewController(navVC)
                }
                
            case .failure(.invalidResponse):
                DispatchQueue.main.async {
                    let permissionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: PermissionViewController.identifier)
                    self?.changeRootViewController(permissionViewController)
                }
            
            default:
                DispatchQueue.main.async {
                    self?.showSystemMaintenanceAlert()
                }
            }
        }
    }
    
    private func checkAppVersion() {
        guard let info = Bundle.main.infoDictionary, let currentVersion = info["CFBundleShortVersionString"] as? String, let _ = info["CFBundleIdentifier"] as? String else { return }

        let policy = realm.objects(Policy.self)
        let versionPolicyObjcet = Array(policy.filter("id == 'APP_VER_IOS'"))
        let appVersion = versionPolicyObjcet[0].value
        if appVersion != currentVersion {
            checkUrgentNotice()
        } else {
            showVersionUpdateAlert()
        }
    }
    
    private func checkUrgentNotice() {
        let policy = realm.objects(Policy.self)
        let noticeContentObject = Array(policy.filter("id == 'POPUP_CONTENT'"))
        let needPopUpNoticeObject = Array(policy.filter("id == 'POPUP_ENABLE_YN'"))
        let needPopUpNotice = needPopUpNoticeObject[0].value
        let noticeContent = noticeContentObject[0].value
      
        // 긴급공지가 같다 - 다음 화면으로 이동
        if needPopUpNotice == "N" {
            requestAutoLogIn()
        } else {
            // 긴급공지가 다를 때 - 긴급공지 다이얼로그를 띄워준다.
            showCustomAlert(alertType: .none, alertTitle: noticeContent, isRightButtonHidden: true, leftButtonTitle: "확인", isMessageLabelHidden: true)
        }
    }
}
