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
