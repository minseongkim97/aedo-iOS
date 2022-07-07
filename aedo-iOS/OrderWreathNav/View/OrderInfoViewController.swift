//
//  OrderInfoViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/06/28.
//

import UIKit
import DropDown

class OrderInfoViewController: UIViewController {
    //MARK: - Properties
    static let identifier = "OrderInfoViewController"
    let orderWreathService = OrderWreathService()
    var item: String = ""
    var price: Int = 0
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var funeralHallPicker: RegisterObituaryCustomTextField!
    @IBOutlet weak var funeralHallTextField: UITextField!
    @IBOutlet weak var placeNameTextField: UITextField!
    @IBOutlet weak var residentTextField: UITextField!
    @IBOutlet weak var residentPhoneNumberTextField: UITextField!
    @IBOutlet weak var ordererTextField: UITextField!
    @IBOutlet weak var ordererPhoneNumberTextField: UITextField!
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var ribbonWordPicker: RegisterObituaryCustomTextField!
    @IBOutlet weak var ribbonWordTextField: UITextField!
    
    let placeMenu: DropDown = {
        let menu = DropDown()
        menu.dataSource = [
            "구례산림조합장례식장",
            "구례병원장례식장",
            "구례효사랑요양병원장례식장",
            "새미소요양병원장례식장"
        ]
        return menu
    }()
    
    let ribbonWordMenu: DropDown = {
        let menu = DropDown()
        menu.dataSource = [
            "1",
            "2",
            "3",
            "4"
        ]
        return menu
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setPlaceDropDown()
        setRibbonWordDropDown()
        setAttribute()
    }
    
    //MARK: - Action
    @IBAction func didTappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func didTappedQMarkButton(_ sender: UIButton) {
        guard let infoVC = UIStoryboard(name: "OrderWreathNav", bundle: nil).instantiateViewController(identifier: OrderAnnounceViewController.identifier) as? OrderAnnounceViewController else { return }
        
        self.navigationController?.pushViewController(infoVC, animated: true)
    }
    
    @IBAction func didTappedOrderButton(_ sender: UIButton) {
        let wreath = Wreath(place: PlaceInfo(name: funeralHallTextField.text!, number: placeNameTextField.text!),
                            receiver: Receiver(name: residentTextField.text!, phone: residentPhoneNumberTextField.text!),
                            sender: Sender(name: ordererTextField.text!, phone: ordererPhoneNumberTextField.text!),
                            word: Word(company: groupNameTextField.text!, word: ribbonWordPicker.text!, wordsecond: ribbonWordTextField.text!),
                            item: self.item,
                            price: self.price,
                            created: self.now())
        
        orderWreathService.orderWreath(wreath: wreath) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                print(response)
                DispatchQueue.main.async {
                    self.showCustomAlert(alertType: .PopSuccess, alertTitle: "주문이 완료되었습니다.", isRightButtonHidden: true, leftButtonTitle: "확인", isMessageLabelHidden: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.showCustomAlert(alertType: .PopError, alertTitle: "주문에 실패하였습니다.\n다시 시도해주세요.", isRightButtonHidden: true, leftButtonTitle: "확인", isMessageLabelHidden: true)
                }
            }
        }
    }
    
    @objc private func didTappedFuneralHallPicker() {
        placeMenu.show()
    }
    
    @objc private func didTappedRibbonWordPicker() {
        ribbonWordMenu.show()
    }
    
    //MARK: - Helpers
    private func setPlaceDropDown() {
        placeMenu.anchorView = funeralHallPicker
        placeMenu.bottomOffset = CGPoint(x: 0, y:(placeMenu.anchorView?.plainView.bounds.height)!)
        placeMenu.backgroundColor = .white
        placeMenu.selectionBackgroundColor = .white
        placeMenu.cornerRadius = 5
        placeMenu.selectionAction = { [weak self] index, title in
            guard let self = self else { return }
            self.funeralHallPicker.text = title
            self.funeralHallTextField.text = title
        }
        
        let placeNamePickerGesture = UITapGestureRecognizer(target: self, action: #selector(didTappedFuneralHallPicker))
        placeNamePickerGesture.numberOfTapsRequired = 1
        placeNamePickerGesture.numberOfTouchesRequired = 1
        funeralHallPicker.addGestureRecognizer(placeNamePickerGesture)
    }
    
    private func setRibbonWordDropDown() {
        ribbonWordMenu.anchorView = ribbonWordPicker
        ribbonWordMenu.bottomOffset = CGPoint(x: 0, y:(ribbonWordMenu.anchorView?.plainView.bounds.height)!)
        ribbonWordMenu.backgroundColor = .white
        ribbonWordMenu.selectionBackgroundColor = .white
        ribbonWordMenu.cornerRadius = 5
        ribbonWordMenu.selectionAction = { [weak self] index, title in
            guard let self = self else { return }
            self.ribbonWordPicker.text = title
            self.ribbonWordTextField.text = title
        }
        
        let ribbonWordPickerGesture = UITapGestureRecognizer(target: self, action: #selector(didTappedRibbonWordPicker))
        ribbonWordPickerGesture.numberOfTapsRequired = 1
        ribbonWordPickerGesture.numberOfTouchesRequired = 1
        ribbonWordPicker.addGestureRecognizer(ribbonWordPickerGesture)
    }
    
    func now() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }
    
    func setAttribute() {
        self.dateLabel.text = self.now()
    }
}
