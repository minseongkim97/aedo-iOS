//
//  RegisterObituaryViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/12.
//

import UIKit
import DropDown
import Photos

class CustomBarButton: UIBarButtonItem {
  var sender: UITextField?
}

enum ToolBarMode {
    case date
    case time
}

class RegisterObituaryViewController: UIViewController {
    //MARK: - Properties
    static let identifier = "RegisterObituaryViewController"
    let registerObituaryService = RegisterObituaryService()
    
    @IBOutlet weak var relationPicker: RegisterObituaryCustomTextField!
    @IBOutlet weak var relationTextButton: UIButton!
    @IBOutlet weak var residentNameTextField: UITextField!
    @IBOutlet weak var residentPhoneNumberTextField: UITextField!
    @IBOutlet weak var placeNamePicker: RegisterObituaryCustomTextField!
    @IBOutlet weak var placeNameTextField: UITextField!
    @IBOutlet weak var deceasedTextField: UITextField!
    @IBOutlet weak var deceasedAgeTextField: UITextField!
    @IBOutlet weak var imageUploadButton: UIButton!
    @IBOutlet weak var deceasedPortraitImageView: UIImageView!
    @IBOutlet weak var deathbedDatePicker: UITextField!
    @IBOutlet weak var deathbedTimePicker: UITextField!
    @IBOutlet weak var coffinDatePicker: UITextField!
    @IBOutlet weak var coffinTimePicker: UITextField!
    @IBOutlet weak var dofpDatePicker: UITextField!
    @IBOutlet weak var dofpTimePicker: UITextField!
    @IBOutlet weak var residentWordTextView: UITextView!
    @IBOutlet weak var buriedPlaceTextField: UITextField!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.timeZone = TimeZone(abbreviation: "KST")
        return datePicker
    }()
    
    let timePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.timeZone = TimeZone(abbreviation: "KST")
        return datePicker
    }()
    
    let relationMenu: DropDown = {
        let menu = DropDown()
        menu.dataSource = [
            "?????????",
            "??????",
            "???",
            "?????????",
            "??????",
            "???",
            "??????",
            "??????",
            "??????",
            "?????????",
            "?????????",
            "??????",
            "??????",
            "?????????",
            "?????????",
            "??????",
            "??????",
            "??????",
            "??????",
            "???",
            "???",
            "???",
            "??????",
            "??????",
            "??????",
            "??????",
            "??????",
            "??????",
            "??????",
            "??????",
            "??????"
        ]
        return menu
    }()
    
    let placeMenu: DropDown = {
        let menu = DropDown()
        menu.dataSource = [
            "??????????????????????????????",
            "????????????????????????",
            "???????????????????????????????????????",
            "?????????????????????????????????"
        ]
        return menu
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboardWhenTappedAround()
        setConfigure()
        setRelationDropDown()
        setPlaceDropDown()
        setPickerView()
    }
    
    private func setPickerView() {
        setDatePickerView(of: deathbedDatePicker)
        setDatePickerView(of: dofpDatePicker)
        setDatePickerView(of: coffinDatePicker)
        
        setTimePickerView(of: deathbedTimePicker)
        setTimePickerView(of: dofpTimePicker)
        setTimePickerView(of: coffinTimePicker)
    }
    //MARK: - Actions
    @IBAction func didTappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTappedUploadImageButton(_ sender: UIButton) {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.delegate = self
        self.present(imagePickerVC, animated: true, completion: nil)
    }
    
    //MARK: - Selector
    @objc func didTappedRelationPicker() {
        relationMenu.show()
    }
    
    @objc func didTappedPlacePicker() {
        placeMenu.show()
    }
    
    @objc func doneButtonPressed(of customBarButton: CustomBarButton) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        customBarButton.sender!.text = dateformatter.string(from: datePicker.date)

        self.view.endEditing(true)
    }
    
    @objc func timeDoneButtonPressed(of customBarButton: CustomBarButton) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "a hh:mm"
        customBarButton.sender!.text = dateformatter.string(from: timePicker.date)
        
        self.view.endEditing(true)
    }
    
    @objc func cancelButtonPressed() {
        self.view.endEditing(true)
    }
    
    @IBAction func didTappedMakeObituary(_ sender: UIButton) {
        activity.startAnimating()
        let now: String = {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString = formatter.string(from: date)
            return dateString
        }()
        
        registerObituaryService.uploadImage(
            request: RegisterObituaryRequest(
                relation: relationPicker.text!,
                residentName: residentNameTextField.text!,
                residentphone: residentPhoneNumberTextField.text!,
                deceasedName: deceasedTextField.text!,
                deceasedAge: deceasedAgeTextField.text!,
                place: placeNameTextField.text!,
                eod: "\(deathbedDatePicker.text!)",
                coffin: "\(coffinDatePicker.text!) \(coffinTimePicker.text!)",
                dofp: "\(dofpDatePicker.text!) \(dofpTimePicker.text!)",
                buried: buriedPlaceTextField.text == "" ? "??????" : buriedPlaceTextField.text,
                word: residentWordTextView.text == "" ? "????????????" : residentWordTextView.text,
                created: now
            ),
            image: deceasedPortraitImageView.image!) { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.activity.stopAnimating()
                }
                
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self.showCustomAlert(alertType: .PopSuccess, alertTitle: "?????? ????????? ?????????????????????.", isRightButtonHidden: true, leftButtonTitle: "??????", isMessageLabelHidden: true)
                    }
                case . failure(.invalidResponse):
                    DispatchQueue.main.async {
                        self.showCustomAlert(alertType: .none, alertTitle: "?????? ???????????? ?????? ?????????????????????.", isRightButtonHidden: true, leftButtonTitle: "??????", isMessageLabelHidden: true)
                    }
                default:
                    DispatchQueue.main.async {
                        self.showCustomAlert(alertType: .none, alertTitle: "??????????????? ???????????? ????????????.", isRightButtonHidden: true, leftButtonTitle: "??????", isMessageLabelHidden: true)
                    }
                }
            }
    }
    
    //MARK: - Helpers
    private func setConfigure() {
        relationTextButton.layer.borderWidth = 0.5
        relationTextButton.layer.borderColor = UIColor.init(hex: 0x9F9F9F).cgColor
        relationTextButton.layer.cornerRadius = 5
        relationTextButton.layer.masksToBounds = true
        
        imageUploadButton.layer.cornerRadius = 5
        imageUploadButton.layer.masksToBounds = true
        
        residentWordTextView.layer.borderWidth = 0.5
        residentWordTextView.layer.borderColor = UIColor.lightGray.cgColor
        residentWordTextView.layer.cornerRadius = 5
        residentWordTextView.layer.masksToBounds = true
    }

    private func setRelationDropDown() {
        relationMenu.anchorView = relationPicker
        relationMenu.bottomOffset = CGPoint(x: 0, y:(relationMenu.anchorView?.plainView.bounds.height)!)
        relationMenu.backgroundColor = .white
        relationMenu.selectionBackgroundColor = .white
        relationMenu.cornerRadius = 5
        relationMenu.selectionAction = { [weak self] index, title in
            guard let self = self else { return }
            self.relationPicker.text = title
            self.relationTextButton.setTitle(title, for: .normal)
        }
        
        let relationPickerGesture = UITapGestureRecognizer(target: self, action: #selector(didTappedRelationPicker))
        relationPickerGesture.numberOfTapsRequired = 1
        relationPickerGesture.numberOfTouchesRequired = 1
        relationPicker.addGestureRecognizer(relationPickerGesture)
    }
    
    private func setPlaceDropDown() {
        placeMenu.anchorView = placeNamePicker
        placeMenu.bottomOffset = CGPoint(x: 0, y:(placeMenu.anchorView?.plainView.bounds.height)!)
        placeMenu.backgroundColor = .white
        placeMenu.selectionBackgroundColor = .white
        placeMenu.cornerRadius = 5
        placeMenu.selectionAction = { [weak self] index, title in
            guard let self = self else { return }
            self.placeNamePicker.text = title
            self.placeNameTextField.text = title
        }
        
        let placeNamePickerGesture = UITapGestureRecognizer(target: self, action: #selector(didTappedPlacePicker))
        placeNamePickerGesture.numberOfTapsRequired = 1
        placeNamePickerGesture.numberOfTouchesRequired = 1
        placeNamePicker.addGestureRecognizer(placeNamePickerGesture)
    }
    
    private func makeToolBar(of sender: UITextField, mode: ToolBarMode) -> UIToolbar {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        toolbar.sizeToFit()
        var doneButton: CustomBarButton
        
        if mode == .date {
            doneButton = CustomBarButton(title: "??????", style: .plain, target: self, action: #selector(doneButtonPressed(of:)))
        } else {
            doneButton = CustomBarButton(title: "??????", style: .plain, target: self, action: #selector(timeDoneButtonPressed(of:)))
        }
        
        doneButton.sender = sender
        let cancelButton = UIBarButtonItem(title: "??????", style: .plain, target: self, action: #selector(cancelButtonPressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.setItems([cancelButton, flexibleSpace, doneButton], animated: true)
        
        return toolbar
    }
    
    private func setDatePickerView(of sender: UITextField) {
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        sender.inputAccessoryView = makeToolBar(of: sender, mode: .date)
        sender.inputView = datePicker
    }
    
    
    private func setTimePickerView(of sender: UITextField) {
        if #available(iOS 13.4, *) {
            timePicker.preferredDatePickerStyle = .wheels
        }

        sender.inputAccessoryView = makeToolBar(of: sender, mode: .time)
        sender.inputView = timePicker
    }
}

//MARK: - Extension: UIImagePickerControllerDelegate
extension RegisterObituaryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            deceasedPortraitImageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
}
