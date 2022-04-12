//
//  CommonQuestionListViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/04/11.
//

import UIKit

struct Answer {
    var question: String
    var answer: String
    var isOpen: Bool
    
    static func EMPTY() -> Answer {
        return Answer(question: "", answer: "", isOpen: false)
    }
}

//class IntrinsicTableView: UITableView {
//    override var intrinsicContentSize: CGSize {
//        let number = numberOfSections
//        var height: CGFloat = 0
//
//        for i in 0..<number {
//            guard let cell = cellForRow(at: IndexPath(row: 0, section: i)) else {
//                continue
//            }
//            height += cell.bounds.height
//        }
//        return CGSize(width: contentSize.width, height: height)
//    }
//}

class CommonQuestionListViewController: UIViewController {
    //MARK: - Properties
    var answers: [Answer] = [
        Answer(question: "Q. 화한 주문 결제가 되지 않아요", answer: "장례식 어플 애도", isOpen: false),
        Answer(question: "Q. 부고 공유가 되지 않아요", answer: "장례식 어플 애도", isOpen: false),
        Answer(question: "Q. 화한 주문 환불이 가능한가요?", answer: "장례식 어플 애도", isOpen: false),
        Answer(question: "Q. 길찾기가 가능한가요?", answer: "장례식 어플 애도", isOpen: false),
        Answer(question: "Q. 부고는 어떻게 작성하나요?", answer: "장례식 어플 애도", isOpen: false)
    ]
    
    @IBOutlet private weak var commonQuestionListTableView: UITableView! {
        didSet {
            commonQuestionListTableView.delegate = self
            commonQuestionListTableView.dataSource = self
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonQuestionListTableView.layer.borderWidth = 0.5
        commonQuestionListTableView.layer.borderColor = UIColor(hex: 0xDDDDDD).cgColor
        commonQuestionListTableView.layer.cornerRadius = 10
        commonQuestionListTableView.layer.shadowOpacity = 0.05
        commonQuestionListTableView.layer.shadowColor = UIColor.black.cgColor
        commonQuestionListTableView.layer.shadowOffset = CGSize(width: 0, height: 10)
        commonQuestionListTableView.layer.shadowRadius = 10
        commonQuestionListTableView.layer.masksToBounds = false
    }
    //MARK: - Helpers
}

//MARK: - Extension: UITableviewDelegate
extension CommonQuestionListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if answers[section].isOpen {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CommonQuestionTableViewCell.identifier, for: indexPath) as! CommonQuestionTableViewCell
            cell.questionLabel.text = answers[indexPath.section].question
            if answers[indexPath.section].isOpen {
                cell.backgroundColor = UIColor(hex: 0xF6F6F6)
                cell.chevronImageView.image = UIImage(systemName: "chevron.up")
                cell.separateLine.isHidden = true
            } else {
                cell.backgroundColor = .systemBackground
                cell.chevronImageView.image = UIImage(systemName: "chevron.down")
                cell.separateLine.isHidden = false
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: AnswerTableViewCell.identifier, for: indexPath) as! AnswerTableViewCell
            cell.answerLabel.text = answers[indexPath.section].answer
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if answers[indexPath.section].isOpen {
            answers[indexPath.section].isOpen = false
        } else {
            answers[indexPath.section].isOpen = true
        }

        let section = IndexSet(integer: indexPath.section)
        tableView.reloadSections(section, with: .none)
    }
}
