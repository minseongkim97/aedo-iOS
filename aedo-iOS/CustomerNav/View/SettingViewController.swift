//
//  SettingViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/14.
//

import UIKit

struct Section {
    let title: String?
    let options: [SettingsOptionType]
}

enum SettingsOptionType {
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingSwitchOption)
    case versionCell(model: SettingVersionOption)
}

struct SettingSwitchOption {
    let title: String
    var isOn: Bool
    let handler: (() -> Void)
}

struct SettingVersionOption {
    let title: String
    let version: String
    let handler: (() -> Void)
}

struct SettingsOption {
    let title: String
    let handler: (() -> Void)
}

class SettingViewController: UIViewController {
    //MARK: - Properties
    static let identifier = "SettingViewController"
    var models = [Section]()
    
    @IBOutlet private weak var settingTableView: UITableView! {
        didSet {
            settingTableView.dataSource = self
            settingTableView.delegate = self
            settingTableView.register(UINib(nibName: SettingStaticTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SettingStaticTableViewCell.identifier)
            settingTableView.register(UINib(nibName: SettingSwitchTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SettingSwitchTableViewCell.identifier)
            settingTableView.register(UINib(nibName: SettingVersionTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SettingVersionTableViewCell.identifier)
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setContribute()
    }
    
    //MARK: - Actions
    
    @IBAction func didTappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helpers
    private func setContribute() {
        settingTableView.layer.masksToBounds = false
        settingTableView.layer.shadowColor = UIColor.black.cgColor
        settingTableView.layer.shadowOpacity = 0.07
        settingTableView.layer.shadowRadius = 10
    }
    private func configure() {
        models.append(
            Section(title: "기능설정", options: [
                .switchCell(model: SettingSwitchOption(title: "자동로그인", isOn: false, handler: {
                    print("Tapped 자동로그인")
                })),
                .switchCell(model: SettingSwitchOption(title: "푸시수신", isOn: true, handler: {
                    print("Tapped 푸시수신")
                }))
            ])
        )
        
        models.append(
            Section(title: "약관상세", options: [
                .staticCell(model: SettingsOption(title: "이용약관", handler: {
                    let privateInfoAccessVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: PrivateInfoAccessViewController.identifier) as! PrivateInfoAccessViewController
                    privateInfoAccessVC.modalPresentationStyle = .fullScreen
                    self.present(privateInfoAccessVC, animated: true)
                })),
                .staticCell(model: SettingsOption(title: "개인정보이용동의", handler: {
                    let privateInfoAccessVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: PrivateInfoAccessViewController.identifier) as! PrivateInfoAccessViewController
                    privateInfoAccessVC.modalPresentationStyle = .fullScreen
                    self.present(privateInfoAccessVC, animated: true)
                })),
                .staticCell(model: SettingsOption(title: "제3자 정보제공 이용동의", handler: {
                    let privateInfoAccessVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: PrivateInfoAccessViewController.identifier) as! PrivateInfoAccessViewController
                    privateInfoAccessVC.modalPresentationStyle = .fullScreen
                    self.present(privateInfoAccessVC, animated: true)
                }))
            ])
        )
        
        models.append(
            Section(title: "계정", options: [
                .staticCell(model: SettingsOption(title: "로그아웃", handler: {
                    print("Tapped 로그아웃")
                })),
                .staticCell(model: SettingsOption(title: "회원탈퇴", handler: {
                    let withdrawalVC = UIStoryboard(name: "CustomerNav", bundle: nil).instantiateViewController(identifier: WithdrawalViewController.identifier) as! WithdrawalViewController
                    self.navigationController?.pushViewController(withdrawalVC, animated: true)
                }))
            ])
        )
        
        models.append(
            Section(title: nil, options: [
                .versionCell(model: SettingVersionOption(title: "버전정보", version: "v 1.0", handler: {
                    print("Tapped 버전정보")
                }))
            ])
        )
    }
}

//MARK: - Extension: UITableView
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = models[section]
        return model.title
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        if let header = view as? UITableViewHeaderFooterView {
//            if section == 0 {
//                header.textLabel?.textColor = .white
//            }
//        }
//    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        switch model {
        case .staticCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingStaticTableViewCell.identifier, for: indexPath) as? SettingStaticTableViewCell else { return UITableViewCell() }
            cell.configure(with: model)
            return cell
        case .switchCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingSwitchTableViewCell.identifier, for: indexPath) as? SettingSwitchTableViewCell else { return UITableViewCell() }
            cell.configure(with: model)
            return cell
        case .versionCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingVersionTableViewCell.identifier, for: indexPath) as? SettingVersionTableViewCell else { return UITableViewCell() }
            cell.configure(with: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        switch type {
        case .staticCell(model: let model):
            model.handler()
        case .switchCell(model: let model):
            model.handler()
        case .versionCell(model: let model):
            model.handler()
        }
    }
}
