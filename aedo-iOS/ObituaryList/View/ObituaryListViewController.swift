//
//  ObituaryListViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/17.
//

import UIKit
import RxSwift

class ObituaryListViewController: UIViewController {
    //MARK: - Properties
    let disposeBag = DisposeBag()
    
    static let identifier = "ObituaryListViewController"
  
    @IBOutlet private weak var ObituaryListTableView: UITableView! {
        didSet {
            ObituaryListTableView.delegate = self
            ObituaryListTableView.dataSource = self
            ObituaryListTableView.register(UINib(nibName: ObituaryListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ObituaryListTableViewCell.identifier)
        }
    }
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - Extension: UITableViewDelegate
extension ObituaryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ObituaryListTableViewCell.identifier, for: indexPath) as? ObituaryListTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
    
}
