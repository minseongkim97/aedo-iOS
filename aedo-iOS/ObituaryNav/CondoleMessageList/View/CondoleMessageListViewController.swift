//
//  ObituaryMessageListViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/18.
//

import UIKit
import RxSwift
import RxCocoa

class CondoleMessageListViewController: UIViewController {
    //MARK: - Properties
    private let disposeBag = DisposeBag()
    var obID: String = "625cbe4e2c2b0c5f008930e2"
    private lazy var condoleMessageListViewModel = CondoleMessageListViewModel(obID: self.obID)
    static let identifier = "CondoleMessageListViewController"
    
    static func instantiate(viewModel: CondoleMessageListViewModel) -> CondoleMessageListViewController {
        let storyboard = UIStoryboard(name: "ObituaryListNav", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! CondoleMessageListViewController
        vc.condoleMessageListViewModel = viewModel
        return vc
    }
    
    @IBOutlet private weak var headerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var headerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var headerViewStack: UIStackView!
    @IBOutlet private weak var floatingButton: UIButton!
    @IBOutlet private weak var condoleCountLabel: UILabel!
    @IBOutlet private weak var condoleMessageListTableView: UITableView! {
        didSet {
            condoleMessageListTableView.tableFooterView = UIView()
            condoleMessageListTableView.register(UINib(nibName: CondoleMessageListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CondoleMessageListTableViewCell.identifier)
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(x: view.frame.size.width - 80, y: view.frame.size.height - 100, width: 60, height: 60)
        floatingButton.layer.masksToBounds = true
        floatingButton.layer.cornerRadius = 30
    }
    
    //MARK: - Helpers
    private func bind() {
        condoleMessageListTableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        condoleMessageListViewModel.condoleMessageList
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] i in
                guard let self = self else { return }
                self.condoleCountLabel.text = "\(i.count)건"
            })
            .disposed(by: disposeBag)

        condoleMessageListViewModel.condoleMessageList
            .asDriver(onErrorJustReturn: [])
            .filter { !$0.isEmpty }
            .drive(condoleMessageListTableView.rx.items(cellIdentifier: CondoleMessageListTableViewCell.identifier, cellType: CondoleMessageListTableViewCell.self)) { (index, viewModel, cell) in
                cell.titleLabel.text = viewModel.titleText
                cell.senderLabel.text = viewModel.senderText
                cell.dateLabel.text = viewModel.dateText
            }
            .disposed(by: disposeBag)
    }
}

//MARK: - Extension: UITableViewDelegate
extension CondoleMessageListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y

        let swipingDown = y <= 170
        let shouldSnap = y > 200

        UIView.animate(withDuration: 0.3) {
            self.headerViewStack.alpha = swipingDown ? 1.0 : 0.0
        }

        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: []) {
            self.headerViewHeightConstraint.constant = shouldSnap ? 0 : 140
            self.view.layoutIfNeeded()
        }
    }
}
