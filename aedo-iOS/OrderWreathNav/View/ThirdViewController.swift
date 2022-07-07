//
//  ThirdViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/06/28.
//

import UIKit

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let nameList = ["1줄 리본 교체", "2줄 리본 교체"]
    let priceList = [15000, 25000]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdCell") as? ThirdCell else { return UITableViewCell() }
        cell.tapAction = { [weak self] in
            guard let self = self else { return  }
            guard let orderVC = UIStoryboard(name: "OrderWreathNav", bundle: nil).instantiateViewController(identifier: OrderInfoViewController.identifier) as? OrderInfoViewController else { return }
            orderVC.item = self.nameList[indexPath.row]
            orderVC.price = self.priceList[indexPath.row]
            self.navigationController?.pushViewController(orderVC, animated: true)
        }
        
        cell.priceLabel.text = "\(priceList[indexPath.row].currencyKR())원"
        cell.nameLabel.text = nameList[indexPath.row]

        return cell
    }
}

class ThirdCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.borderWidth = 0.5
            containerView.layer.borderColor = UIColor(hex: 0xDDDDDD).cgColor
            containerView.layer.cornerRadius = 10
            containerView.layer.shadowOpacity = 0.15
            containerView.layer.shadowRadius = 3
            containerView.layer.shadowColor = UIColor.black.cgColor
            containerView.layer.shadowOffset = CGSize(width: 2, height: 2)
        }
    }
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var orderView: UIView! {
        didSet {
            orderView.layer.borderColor = UIColor(hex: 0xDDDDDD).cgColor
            orderView.layer.borderWidth = 0.5
            orderView.layer.cornerRadius = 5.0
            orderView.layer.shadowColor = UIColor.black.cgColor
            orderView.layer.shadowOpacity = 0.15
            orderView.layer.shadowRadius = 3.0
            orderView.layer.shadowOffset = CGSize(width: 2, height: 2)
        }
    }
    var tapAction: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))

            orderView.addGestureRecognizer(tapGesture)
      }

      @objc func handleTap(sender: UITapGestureRecognizer) {
          tapAction?()
    }
}
