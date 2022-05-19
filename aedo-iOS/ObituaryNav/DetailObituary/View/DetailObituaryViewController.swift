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

class DetailObituaryViewController: UIViewController {
    //MARK: - Properties
    private let disposeBag = DisposeBag()
    var name: String = ""
    private var detailObituaryViewModel: DetailObituaryViewModel!
    static let identifier = "DetailObituaryViewController"
    @IBOutlet weak var deceasedNameLabel: UILabel!
    @IBOutlet weak var eodLabel: UILabel!
    @IBOutlet weak var residentRelationLabel: UILabel!
    @IBOutlet weak var residentNameLabel: UILabel!
    
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var coffinLabel: UILabel!
    @IBOutlet weak var dofpLabel: UILabel!
    @IBOutlet weak var buriedPlaceLabel: UILabel!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var mapAddressLabel: UILabel!
    
    @IBOutlet weak var countCondoleMessageLabel: UILabel!
    static func instantiate(viewModel: DetailObituaryViewModel) -> DetailObituaryViewController {
        let storyboard = UIStoryboard(name: "ObituaryListNav", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! DetailObituaryViewController
        vc.detailObituaryViewModel = viewModel
        return vc
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttribute()
    }
    
    //MARK: - Helpers
    private func setAttribute() {
        let nmapView = NMFNaverMapView()
        mapView.addSubview(nmapView)
    }
}

