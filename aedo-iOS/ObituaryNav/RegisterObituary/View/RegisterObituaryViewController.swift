//
//  RegisterObituaryViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/12.
//

import UIKit
import DropDown

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
    @IBOutlet weak var relationPicker: UITextField!
    @IBOutlet weak var relationTextButton: UIButton!
    @IBOutlet weak var residentNameTextField: RegisterObituaryCustomTextField!
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
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = .white
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.timeZone = TimeZone(abbreviation: "KST")
        return datePicker
    }()
    
    let timePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = .white
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.timeZone = TimeZone(abbreviation: "KST")
        return datePicker
    }()
    
    let relationMenu: DropDown = {
        let menu = DropDown()
        menu.dataSource = [
            "아들",
            "딸"
        ]
        return menu
    }()
    
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
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
        setDropDown()
    }
    
    //MARK: - Actions
    @IBAction func didTappedDatePicker(_ sender: UITextField) {
        setDatePickerView(of: sender)
    }
    
    @IBAction func didTappedTimePicker(_ sender: UITextField) {
        setTimePickerView(of: sender)
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

    private func setDropDown() {
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
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        var doneButton: CustomBarButton
        
        if mode == .date {
            doneButton = CustomBarButton(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed(of:)))
        } else {
            doneButton = CustomBarButton(barButtonSystemItem: .done, target: self, action: #selector(timeDoneButtonPressed(of:)))
        }
        
        doneButton.sender = sender
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonPressed))
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

//MARK: - Extension: PickerViewDelegate, PickerViewDataSource
extension RegisterObituaryViewController {
    
}
