//
//  FirstViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/06/28.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let nameList = ["[근조] 3단화환 1호", "[근조] 3단화환 2호", "[근조] 3단화환 3호", "[근조] 4단화환 1호"]
    let priceList = [77000, 88000, 99000, 145000]
    let percentList = ["10%", "12%", "18%", "20%"]
    let originList = ["85,000원", "100,000원", "120,000원", "180,000원"]
    let isCellBest = [true, false, true, true]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 121
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FirstCell", for: indexPath) as? FirstCell else { return UITableViewCell() }
        cell.tapAction = { [weak self] in
            guard let self = self else { return }
            guard let orderVC = UIStoryboard(name: "OrderWreathNav", bundle: nil).instantiateViewController(identifier: OrderInfoViewController.identifier) as? OrderInfoViewController else { return }
            orderVC.item = self.nameList[indexPath.row]
            orderVC.price = self.priceList[indexPath.row]
            
            self.navigationController?.pushViewController(orderVC, animated: true)
        }
        
        cell.nameLabel.text = nameList[indexPath.row]
        cell.priceLabel.text = "\(priceList[indexPath.row].currencyKR())원"
        cell.percentLabel.text = percentList[indexPath.row]
        cell.originLabel.text = originList[indexPath.row]
        cell.starImgView.isHidden = isCellBest[indexPath.row]
        cell.bestLabel.isHidden = isCellBest[indexPath.row]
        
        return cell
    }
}
