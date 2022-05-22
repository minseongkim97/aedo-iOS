//
//  ObituaryListViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/17.
//

import UIKit
import RxSwift
import RxCocoa

class ObituaryListViewController: UIViewController {
    //MARK: - Properties
    private let disposeBag = DisposeBag()
    private let obituaryListViewModel = ObituaryListViewModel()

    static let identifier = "ObituaryListViewController"
    
    @IBOutlet private weak var obituaryListTableView: UITableView! {
        didSet {
            obituaryListTableView.register(UINib(nibName: ObituaryListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ObituaryListTableViewCell.identifier)
        }
    }
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setBinding()
    }
    
    //MARK: - Actions
    @IBAction func didTappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTappedHomeButton(_ sender: UIButton) {
        let mainViewController = UIStoryboard(name: "MainNav", bundle: nil).instantiateViewController(identifier: MainViewController.identifier)
        let navVC = UINavigationController(rootViewController: mainViewController)
        navVC.isNavigationBarHidden = true
        self.changeRootViewController(navVC)
    }
    
    //MARK: - Helpers
    private func setBinding() {
        obituaryListTableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        obituaryListViewModel.obituaryList
            .observe(on: MainScheduler.instance)
            .filter { !$0.isEmpty }
            .bind(to: obituaryListTableView.rx.items(cellIdentifier: ObituaryListTableViewCell.identifier, cellType: ObituaryListTableViewCell.self)) { (index, item, cell) in
                cell.updateUI(item: item)
                cell.showDetailObituaryButtonAction = { [weak self] in
                    guard let self = self else { return }
                    let detailObituaryVC = UIStoryboard(name: "ObituaryListNav", bundle: nil).instantiateViewController(identifier: DetailObituaryViewController.identifier) as! DetailObituaryViewController
                    detailObituaryVC.deceasedName = cell.nameLabel.text!
                    detailObituaryVC.obID = cell.obID
                    self.navigationController?.pushViewController(detailObituaryVC, animated: true)
                }
                cell.sendObituaryButtonAction = { [weak self] in
                    guard let self = self else { return }
                    self.showCustomAlert(alertType: .none, alertTitle: "해당 기능은 준비중입니다.", isRightButtonHidden: true, leftButtonTitle: "확인", isMessageLabelHidden: true)
                    
                }
            }
            .disposed(by: disposeBag)
    }
}

//MARK: - Extension: UITableViewDelegate
extension ObituaryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
    
   
}
