//
//  BusinessmanInfoViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/19.
//

import UIKit

class BusinessmanInfoViewController: UIViewController {
    //MARK: - Properties
    static let identifier = "BusinessmanInfoViewController"
    let businessInfo = [
        "1. 사업자 대표",
        "대표: 박 인 호",
        "2. 상호명",
        "청란플라워",
        "3. 주소",
        "전라남도 구례군 구례읍 구례2길 83-1",
        "4. 사업자 번호",
        "448-92-01531",
        "5. 사업 종류",
        "업태: 도소매",
        "6. 유선전화: 010-2299-2968",
        "7. 이메일: haru_92@naver.com",
        "8. 통신판매업신고번호",
        "제 2022-전남 구례-9호"
    ]
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var infoTableView: UITableView! {
        didSet {
            infoTableView.delegate = self
            infoTableView.dataSource = self
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
        containerView.layer.shadowOpacity = 0.3
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 8)
        containerView.layer.shadowRadius = 10
        containerView.layer.cornerRadius = 10
        containerView.layer.borderColor = UIColor(hex: 0xDDDDDD).cgColor

        infoTableView.layer.cornerRadius = 10
        infoTableView.layer.masksToBounds = true
    }
}

//MARK: - Extension: UITableViewDelegate, UITableViewDataSource
extension BusinessmanInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 14
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BusinessInfoTableViewCell.identifier, for: indexPath) as! BusinessInfoTableViewCell
        cell.contentLabel.text = businessInfo[indexPath.row]
        if indexPath.row % 2 != 0 && indexPath.row != 12 {
            cell.contentView.backgroundColor = .systemGroupedBackground
            cell.contentLabel.font = UIFont(name: "NotoSansCJKkr-Regular", size: 15)
            cell.contentLabel.textColor = .darkGray
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
