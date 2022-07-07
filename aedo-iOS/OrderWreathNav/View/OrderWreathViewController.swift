//
//  OrderWreathViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/06/27.
//

import UIKit
import PagingKit

class OrderWreathViewController: UIViewController {
    //MARK: - Properties
    static let identifier = "OrderWreathViewController"
    var menuViewController: PagingMenuViewController!
    var contentViewController: PagingContentViewController!
        
    var dataSource = [(menu: String, content: UIViewController)]() {
        didSet {
            menuViewController.reloadData()
            contentViewController.reloadData()
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        menuViewController.register(nib: UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
        menuViewController.registerFocusView(nib: UINib(nibName: "FocusView", bundle: nil))
        
        menuViewController.cellAlignment = .center
        
        menuViewController.reloadData()
        contentViewController.reloadData()
        
        dataSource = makeDataSource()
    }
    
    //MARK: - Action
    @IBAction func didTappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTappedInfoButton(_ sender: UIButton) {
        guard let infoVC = UIStoryboard(name: "OrderWreathNav", bundle: nil).instantiateViewController(identifier: OrderAnnounceViewController.identifier) as? OrderAnnounceViewController else { return }
        
        self.navigationController?.pushViewController(infoVC, animated: true)
    }
    
    
    //MARK: - Helpers
    fileprivate func makeDataSource() -> [(menu: String, content: UIViewController)] {
        let myMenuArray = ["근조화환", "바구니/오브제", "리본교체"]
        
        return myMenuArray.map {
            let title = $0
            
            switch title {
            case "근조화환":
                let vc = UIStoryboard(name: "OrderWreathNav", bundle: nil).instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
                return (menu: title, content: vc)
                
            case "바구니/오브제":
                let vc = UIStoryboard(name: "OrderWreathNav", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
                return (menu: title, content: vc)
                
            case "리본교체":
                let vc = UIStoryboard(name: "OrderWreathNav", bundle: nil).instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
                return (menu: title, content: vc)
                
            default :
                let vc = UIStoryboard(name: "OrderWreathNav", bundle: nil).instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
                return (menu: title, content: vc)
            }
        }
    }
}

extension OrderWreathViewController: PagingMenuViewControllerDataSource, PagingMenuViewControllerDelegate, PagingContentViewControllerDataSource, PagingContentViewControllerDelegate {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PagingMenuViewController {
            menuViewController = vc
            menuViewController.dataSource = self
            menuViewController.delegate = self
        } else if let vc = segue.destination as? PagingContentViewController {
            contentViewController = vc
            contentViewController.dataSource = self
            contentViewController.delegate = self
        }
    }
    
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count
    }
    
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        return self.view.frame.width / 3
    }
    
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: index) as! MenuCell
        cell.titleLabel.text = dataSource[index].menu
        
        return cell
    }
    
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
          return dataSource.count
      }
    
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return dataSource[index].content
    }
    
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
           contentViewController.scroll(to: page, animated: true)
    }
    
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
            menuViewController.scroll(index: index, percent: percent, animated: false)
    }
}
