//
//  PermissionViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/01.
//

import UIKit
import EventKit
import AVFoundation
import Photos
import CoreLocation
import UserNotifications

class PermissionViewController: UIViewController, UNUserNotificationCenterDelegate {
    //MARK: - Properties
    static let identifier = "PermissionViewController"
    
    private var isPermission: Bool = true {
        didSet {
            if isPermission == false {
                DispatchQueue.main.async {
                    self.showPermissionAlert()
                }
            }
        }
    }
    private var locationManager = CLLocationManager()
    
    @IBOutlet private weak var alarmTitleLabel: UILabel!
    @IBOutlet private weak var alarmOptionLabel: UILabel!
    @IBOutlet private weak var alarmSubscriptLabel: UILabel!
    @IBOutlet private weak var checkButton: CustomCheckButton!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setUI()
    }
    
    //MARK: - Actions
    @IBAction private func didTappedCheckButton() {
        UserDefaults.standard.set(1, forKey: "firstLaunch")
        let authViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: AuthViewController.identifier)
        let navVC = UINavigationController(rootViewController: authViewController)
        navVC.isNavigationBarHidden = true
        self.changeRootViewController(navVC)
    }

    
    //MARK: - Helpers
    private func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] isCameraPermission in
            if isCameraPermission {
                self?.requestAlbumPermission()
            } else {
                self?.isPermission = false
            }
        }
    }
    
    private func requestAlbumPermission() {
        self.requestAlarmPermission()
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            switch status {
            case .authorized, .limited:
                self?.requestAlarmPermission()
            default:
                self?.isPermission = false
            }
        }
    }
    
    private func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func requestAlarmPermission() {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { isAlarmPermission, error in
            if isAlarmPermission {
                UserDefaults.standard.set(true, forKey: "alarm")
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
    
    private func setUI() {
        alarmTitleLabel.attributedText = NSAttributedString(
            string: "알림",
            attributes: [
                .font: UIFont.NotoSans(.medium, size: 16),
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ])
        alarmOptionLabel.attributedText = NSAttributedString(
            string: "(선택)",
            attributes: [
                .font: UIFont.NotoSans(.regular, size: 13),
                .foregroundColor: UIColor.darkGray,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ])
        alarmSubscriptLabel.attributedText = NSAttributedString(
            string: "공지 및 PUSH 알림",
            attributes: [
                .font: UIFont.NotoSans(.regular, size: 13),
                .foregroundColor: UIColor.darkGray,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ])
    }
    
    private func setDelegate() {
        locationManager.delegate = self
        UNUserNotificationCenter.current().delegate = self
    }
}

//MARK: - Extension
extension PermissionViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            requestCameraPermission()
        case .notDetermined:
            requestLocationPermission()
        case .restricted, .denied:
            isPermission = false
        default:
            break
        }
    }
}

