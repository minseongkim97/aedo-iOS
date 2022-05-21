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
    lazy var mainSettings = [
        SettingsOption(title: "공지사항", handler: {
            let noticeVC = UIStoryboard(name: "CustomerNav", bundle: nil).instantiateViewController(identifier: CustomerNoticeListViewController.identifier) as! CustomerNoticeListViewController
            self.navigationController?.pushViewController(noticeVC, animated: true)
    }),
    SettingsOption(title: "자주 묻는 질문", handler: {
        let commonQuestionVC = UIStoryboard(name: "CustomerNav", bundle: nil).instantiateViewController(identifier: CommonQuestionListViewController.identifier) as! CommonQuestionListViewController
        self.navigationController?.pushViewController(commonQuestionVC, animated: true)
    }),
    SettingsOption(title: "나의 민원", handler: {
        self.openSFSafariView("http://pf.kakao.com/_Xuvxeb/chat")
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
    
    @IBAction func didTappedPhoneCallButton(_ sender: UIButton) {
        let number:Int = 1028320516
                
        // URLScheme 문자열을 통해 URL 인스턴스를 만들어 줍니다.
        if let url = NSURL(string: "tel://0" + "\(number)"),
        
           //canOpenURL(_:) 메소드를 통해서 URL 체계를 처리하는 데 앱을 사용할 수 있는지 여부를 확인
           UIApplication.shared.canOpenURL(url as URL) {
           
           //사용가능한 URLScheme이라면 open(_:options:completionHandler:) 메소드를 호출해서
           //만들어둔 URL 인스턴스를 열어줍니다.
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
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
