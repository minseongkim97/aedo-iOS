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
    
}
