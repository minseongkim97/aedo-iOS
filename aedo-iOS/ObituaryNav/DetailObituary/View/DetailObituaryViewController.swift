//
//  DetailObituaryViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/08.
//

import UIKit
import RxSwift
import RxCocoa
import NMapsMap
import RealmSwift
import CoreLocation

class DetailObituaryViewController: UIViewController {
    //MARK: - Properties
    private let disposeBag = DisposeBag()
    var deceasedName: String = ""
    var obID: String = ""
    var placeID: String = ""
    static let identifier = "DetailObituaryViewController"
    lazy private var detailObituaryViewModel = DetailObituaryViewModel(name: self.deceasedName, obID: obID)
    
    @IBOutlet weak var deceasedNameLabel: UILabel!
    @IBOutlet weak var eodLabel: UILabel!
    @IBOutlet weak var residentRelationLabel: UILabel!
    @IBOutlet weak var residentNameLabel: UILabel!
    
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var coffinLabel: UILabel!
    @IBOutlet weak var dofpLabel: UILabel!
    @IBOutlet weak var buriedPlaceLabel: UILabel!
    @IBOutlet weak var mapView: NMFNaverMapView!
    @IBOutlet weak var mapAddressLabel: UILabel!
    
    @IBOutlet weak var countCondoleMessageLabel: UILabel!
    @IBOutlet weak var condoleMessageWriterLabel: UILabel!
    @IBOutlet weak var condoleMessageCreatedLabel: UILabel!
    @IBOutlet weak var condoleMessageLabel: UILabel!
    @IBOutlet weak var viewCondoleMessageButton: UIButton!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttribute()
        setBinding()
    }
    
    //MARK: - Actions
    @IBAction func didTappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTappedWriteCondoleMessageButton(_ sender: UIButton) {
        let registerCondoleMessageVC = UIStoryboard(name: "ObituaryListNav", bundle: nil).instantiateViewController(identifier: RegisterCondoleMessageViewController.identifier) as! RegisterCondoleMessageViewController
        registerCondoleMessageVC.obID = self.obID
        self.navigationController?.pushViewController(registerCondoleMessageVC, animated: true)
    }
    
    @IBAction func didTappedViewAllCondoleMessageButton(_ sender: UIButton) {
        let condoleMessageListVC = UIStoryboard(name: "ObituaryListNav", bundle: nil).instantiateViewController(identifier: CondoleMessageListViewController.identifier) as! CondoleMessageListViewController
        condoleMessageListVC.obID = self.obID
        self.navigationController?.pushViewController(condoleMessageListVC, animated: true)
    }
    
    //MARK: - Helpers
    private func setAttribute() {
        viewCondoleMessageButton.layer.borderColor = UIColor(hex: 0x955B31).cgColor
        viewCondoleMessageButton.layer.borderWidth = 1
        
    }
    
    private func setBinding() {
        detailObituaryViewModel.detailObituaryList
            .observe(on: MainScheduler.instance)
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.deceasedNameLabel.text = "故 \($0[0].deceased.name)(\($0[0].deceased.age)세)"
                self.eodLabel.text = "\($0[0].eod) 별세"
                self.residentRelationLabel.text = $0[0].resident.relation
                self.residentNameLabel.text = $0[0].resident.name
                
                self.placeLabel.text = $0[0].place
                let (lat, lng) = self.getPlaceFromRealm(place: $0[0].place)
                self.moveCamera(lat: lat, lng: lng)
                self.markPlace(lat: lat, lng: lng)
                let location = CLLocation(latitude: lat, longitude: lng)
                let geocoder = CLGeocoder()
                let locale = Locale(identifier: "Ko-kr")
                geocoder.reverseGeocodeLocation(location, preferredLocale: locale) { [weak self] placemarks, _ in
                    guard let placemarks = placemarks, let address = placemarks.last else { return }
                    DispatchQueue.main.async {
                        self?.mapAddressLabel.text = "\(address.administrativeArea ?? "") \(address.locality ?? "") \(address.thoroughfare ?? "") \(address.subThoroughfare ?? "")"
                    }
                }
                
                self.coffinLabel.text = $0[0].coffin
                self.dofpLabel.text = $0[0].dofp
                self.buriedPlaceLabel.text = $0[0].buried
            })
            .disposed(by: disposeBag)

        detailObituaryViewModel.condoleMessageList
            .observe(on: MainScheduler.instance)
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.countCondoleMessageLabel.text = "\($0.count)"
                self.condoleMessageWriterLabel.text = "\($0[0].senderText)"
                self.condoleMessageCreatedLabel.text = "\($0[0].dateText)"
                self.condoleMessageLabel.text = "\($0[0].titleText)"
            })
            .disposed(by: disposeBag)
    }
}

//MARK: - Extension: naver maps
extension DetailObituaryViewController {
    private func getPlaceFromRealm(place: String) -> (lat: Double, lng: Double) {
        let realm = try! Realm()
        let policy = realm.objects(Coordinate.self)
        let place = policy.filter("name == '\(place)'")
        return (place[0].xvalue, place[0].yvalue)
    }
    
    private func moveCamera(lat: Double, lng: Double) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng))
        mapView.mapView.moveCamera(cameraUpdate)
    }
    
    private func markPlace(lat: Double, lng: Double) {
        let marker = NMFMarker()
        marker.iconImage = NMF_MARKER_IMAGE_BLACK
        marker.iconTintColor = UIColor(hex: 0xF3B368)
        marker.position = NMGLatLng(lat: lat, lng: lng)
        marker.mapView = mapView.mapView
    }
}
