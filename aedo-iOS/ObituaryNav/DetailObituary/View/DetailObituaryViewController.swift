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
    var deceasedName: String = ""
    var obID: String = ""
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
    @IBOutlet weak var mapView: UIView!
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
    }
    
    @IBAction func didTappedViewAllCondoleMessageButton(_ sender: UIButton) {
    }
    
    //MARK: - Helpers
    private func setAttribute() {
        let nmapView = NMFNaverMapView()
        mapView.addSubview(nmapView)
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
                self.coffinLabel.text = $0[0].coffin
                self.dofpLabel.text = $0[0].dofp
                self.buriedPlaceLabel.text = $0[0].buried
            })
            .disposed(by: disposeBag)
        
        print(obID)
        detailObituaryViewModel.condoleMessageList
            .observe(on: MainScheduler.instance)
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.viewCondoleMessageButton.isHidden = false
                self.countCondoleMessageLabel.text = "\($0.count)"
                self.condoleMessageWriterLabel.text = "\($0[0].senderText)"
                self.condoleMessageCreatedLabel.text = "\($0[0].dateText)"
                self.condoleMessageLabel.text = "\($0[0].titleText)"
            })
            .disposed(by: disposeBag)
    }
}

