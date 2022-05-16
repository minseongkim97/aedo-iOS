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

class DynamicHeightTableView: UITableView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.invalidateIntrinsicContentSize()
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}

class CommonQuestionListViewController: UIViewController {
    //MARK: - Properties
    static let identifier = "CommonQuestionListViewController"
    var answers: [Answer] = [
        Answer(question: "Q. 화한 주문 결제가 되지 않아요", answer: "장례식 어플 애도\n장례식 어플 애도\n장례식 어플 애도\n장례식 어플 애도\n장례식 어플 애도", isOpen: false),
        Answer(question: "Q. 부고 공유가 되지 않아요", answer: "장례식 어플 애도", isOpen: false),
        Answer(question: "Q. 화한 주문 환불이 가능한가요?", answer: "장례식 어플 애도\n장례식 어플 애도\n장례식 어플 애도\n장례식 어플 애도\n장례식 어플 애도", isOpen: false),
        Answer(question: "Q. 길찾기가 가능한가요?", answer: "장례식 어플 애도\n장례식 어플 애도\n장례식 어플 애도\n장례식 어플 애도\n장례식 어플 애도", isOpen: false),
        Answer(question: "Q. 부고는 어떻게 작성하나요?", answer: "장례식 어플 애도", isOpen: false)
    ]
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var commonQuestionListTableView: DynamicHeightTableView! {
        didSet {
            commonQuestionListTableView.delegate = self
            commonQuestionListTableView.dataSource = self
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setContribute()
    }
    
    //MARK: - Actions
    @IBAction func didTappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helpers
    private func setContribute() {
        containerView.layer.shadowOpacity = 0.05
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 10)
        containerView.layer.shadowRadius = 10
        containerView.layer.borderWidth = 0.5
        containerView.layer.cornerRadius = 10
        containerView.layer.borderColor = UIColor(hex: 0xDDDDDD).cgColor
        
        commonQuestionListTableView.layer.cornerRadius = 10
        commonQuestionListTableView.layer.masksToBounds = true
    }
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
                cell.contentView.backgroundColor = UIColor(hex: 0xF6F6F6)
                cell.chevronImageView.image = UIImage(systemName: "chevron.up")
                cell.separateLine.isHidden = true
            } else {
                cell.contentView.backgroundColor = .systemBackground
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
