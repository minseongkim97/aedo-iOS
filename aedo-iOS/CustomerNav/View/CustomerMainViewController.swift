//
//  CustomerMainViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/05.
//

import UIKit

class CustomerMainViewController: UIViewController {
    //MARK: - Properties
    static let identifier = "CustomerMainViewController"
    let mainSettings = [
        SettingsOption(title: "공지사항", handler: {
        print("공지사항")
    }),
    SettingsOption(title: "자주 묻는 질문", handler: {
        print("자주 묻는 질문")
    }),
    SettingsOption(title: "나의 민원", handler: {
        print("나의 민원")
    })
    ]
    
    @IBOutlet private weak var customerCenterVeiw: UIView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet weak var customerMainTableView: DynamicHeightTableView! {
        didSet {
            customerMainTableView.delegate = self
            customerMainTableView.dataSource = self
            customerMainTableView.register(UINib(nibName: SettingStaticTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SettingStaticTableViewCell.identifier)
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setContribute()
    }
    
    //MARK: - Actions
    @IBAction func didTappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helpers
    private func setContribute() {
        customerCenterVeiw.layer.cornerRadius = 10
        customerCenterVeiw.layer.shadowOpacity = 0.08
        customerCenterVeiw.layer.shadowColor = UIColor.black.cgColor
        customerCenterVeiw.layer.shadowOffset = CGSize(width: 4, height: 10)
        customerCenterVeiw.layer.shadowRadius = 10
        customerCenterVeiw.layer.masksToBounds = false
        
        containerView.layer.shadowOpacity = 0.05
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 10)
        containerView.layer.shadowRadius = 10
        containerView.layer.borderWidth = 0.5
        containerView.layer.cornerRadius = 10
        containerView.layer.borderColor = UIColor(hex: 0xDDDDDD).cgColor
        customerMainTableView.layer.cornerRadius = 10
        customerMainTableView.layer.masksToBounds = true
    }
}

//MARK: - Extension: UITableViewDelegate, UITableViewDataSource
extension CustomerMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainSettings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = mainSettings[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingStaticTableViewCell.identifier, for: indexPath) as? SettingStaticTableViewCell else { return UITableViewCell() }
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        mainSettings[indexPath.row].handler()
    }
}
