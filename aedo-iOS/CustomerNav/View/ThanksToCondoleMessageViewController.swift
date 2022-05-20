//
//  BusinessmanInfoViewController.swift
//  aedo-iOS
//
//  Created by MIN SEONG KIM on 2022/05/19.
//

import UIKit

class ThanksToCondoleMessageViewController: UIViewController {
    //MARK: - Properties
    static let identifier = "ThanksToCondoleMessageViewController"
    var answers: [Answer] = [
        Answer(question: "Q. 1. 조문감사", answer: "바쁘신 중에도 장례에 오셔서 위로해주셔서 정말 감사드립니다.\n건강 하시길 기도 드리며 다시 한번 더 감사의 인사를 드립니다.", isOpen: false),
        Answer(question: "Q. 2. 조문감사", answer: "기도와 위로 주시고 슬픔을 함께 해주셔서 장례를 잘 마칠 수 있었습니다.\n고마운 마음 잊지 않고 오래도록 기억 하겠습니다.\n다시 한번 감사의 인사드립니다.", isOpen: false),
        Answer(question: "Q. 3. 조문감사", answer: "바쁘신 와중에도 참석하여 따뜻한 위로의 말씀을 해주신 점 깊이 감사드립니다.\n덕분에 장례는 무사히 마치게 되었습니다.\n정말 큰 위로와 힘이 되었으며 감사한 마음을 오래도록 잊지 않고 간직 하겠습니다.", isOpen: false),
        Answer(question: "Q. 4. 조문감사", answer: "먼곳에서 조문을 와주시고 따뜻한 조위와 후의를 베풀어 주시어 무사히 장례를 마칠 수 있었습니다.\n깊은 감사드립니다.", isOpen: false),
        Answer(question: "Q. 5. 조문감사", answer: "직접 찾아뵙지 않고 문자를 통해서 감사의 인사를 드리는 부분 양해 부탁드립니다.\n다시 한번 감사 드리고 가정의 평안과 행운이 가득 하시길 기원하겠습니다.", isOpen: false)
    ]
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var thanksToCondoleMessageTableView: DynamicHeightTableView! {
        didSet {
            thanksToCondoleMessageTableView.delegate = self
            thanksToCondoleMessageTableView.dataSource = self
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

        thanksToCondoleMessageTableView.layer.cornerRadius = 10
        thanksToCondoleMessageTableView.layer.masksToBounds = true
    }
}

//MARK: - Extension: UITableviewDelegate
extension ThanksToCondoleMessageViewController: UITableViewDelegate, UITableViewDataSource {
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
                cell.chevronImageView.image = UIImage(systemName: "chevron.up")
                cell.separateLine.isHidden = true
            } else {
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
