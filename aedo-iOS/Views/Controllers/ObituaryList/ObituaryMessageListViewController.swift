//
//  ObituaryMessageListViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/18.
//

import UIKit

class ObituaryMessageListViewController: UIViewController {
    //MARK: - Properties
    static let identifier = "ObituaryMessageListViewController"
    
    @IBOutlet private weak var headerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var headerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var headerViewStack: UIStackView!
    @IBOutlet private weak var floatingButton: UIButton!
    @IBOutlet private weak var obituaryMessageListTableView: UITableView! {
        didSet {
            obituaryMessageListTableView.delegate = self
            obituaryMessageListTableView.dataSource = self
            obituaryMessageListTableView.register(UINib(nibName: ObituaryMessageListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ObituaryMessageListTableViewCell.identifier)
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(x: view.frame.size.width - 80, y: view.frame.size.height - 100, width: 60, height: 60)
        floatingButton.layer.masksToBounds = true
        floatingButton.layer.cornerRadius = 30
    }
}

//MARK: - Extension: UITableViewDelegate
extension ObituaryMessageListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ObituaryMessageListTableViewCell.identifier, for: indexPath) as? ObituaryMessageListTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        
        let swipingDown = y <= 0
        let shouldSnap = y > 30
        
        UIView.animate(withDuration: 0.3) {
            self.headerViewStack.alpha = swipingDown ? 1.0 : 0.0
        }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: []) {
            self.headerViewHeightConstraint.constant = shouldSnap ? 0 : 140
            self.view.layoutIfNeeded()
        }

    }
    
}
