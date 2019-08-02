//
//  MainGameViewController.swift
//  GuessWho
//
//  Created by Steven Leyva on 7/31/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class MainGameViewController: UIViewController {
    
    @IBOutlet weak var choiceButton3: UIButton!
    @IBOutlet weak var choiceButton2: UIButton!
    @IBOutlet weak var choiceButton1: UIButton!
    @IBOutlet weak var catagoriesLabel: UILabel!
    @IBOutlet weak var twitterTextView: UITextView!
    @IBOutlet weak var timeandDateLabel: UILabel!
    @IBOutlet weak var userName1Label: UILabel!
    @IBOutlet weak var userName2Label: UILabel!
    @IBOutlet weak var userName3Label: UILabel!
    @IBOutlet weak var twitterHandler1Label: UILabel!
    @IBOutlet weak var twitterHandler2Label: UILabel!
    @IBOutlet weak var twitterHandler3Label: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var picture1Image: UIImageView!
    @IBOutlet weak var picture2Image: UIImageView!
    @IBOutlet weak var picture3Image: UIImageView!
    var answerId: Int?

    fileprivate func setImage(_ candidateImage: String, _ candidateImageView: UIImageView) {
        HTTPClient.shared.downloadImage(fromURLString: candidateImage, completion: { (error, image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                candidateImageView.image = image
            }
        })
    }
    
    fileprivate func updateViews() {
        scoreLabel.text = "\(Score.shared.userScore)"
        
        HTTPClient.shared.getNewQuestion { (question, error) in
            guard let question = question else { return }
            
            self.answerId = question.answer.id
            
            let candidateOneImage = question.candidates[0].candidateInfo.profileImageURL
            let candidateTwoImage = question.candidates[1].candidateInfo.profileImageURL
            let candidateThreeImage = question.candidates[2].candidateInfo.profileImageURL
            
            self.setImage(candidateOneImage, self.picture1Image)
            self.setImage(candidateTwoImage, self.picture2Image)
            self.setImage(candidateThreeImage, self.picture3Image)
            
            DispatchQueue.main.async {
                self.twitterTextView.text = question.question
                self.twitterHandler1Label.text = question.candidates[0].handle
                self.twitterHandler2Label.text = question.candidates[1].handle
                self.twitterHandler3Label.text = question.candidates[2].handle
                self.userName1Label.text = question.candidates[0].candidateInfo.name
                self.userName2Label.text = question.candidates[1].candidateInfo.name
                self.userName3Label.text = question.candidates[2].candidateInfo.name
                self.likeCountLabel.text = String(question.answer.favouritesCount)
                self.retweetCountLabel.text = String(question.answer.followersCount)
                self.commentCountLabel.text = String(question.answer.statusesCount)
                
                self.choiceButton1.tag = question.candidates[0].candidateInfo.id
                self.choiceButton2.tag = question.candidates[1].candidateInfo.id
                self.choiceButton3.tag = question.candidates[2].candidateInfo.id
            }
        }
        
        [choiceButton1, choiceButton2, choiceButton3].forEach { (button) in
            button?.isEnabled = true
            button?.backgroundColor = .white
            button?.layer.opacity = 1.0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func GameLogic(sender: UIButton) {
        // Loop over each button using forEach
        // Set each button to be disabled via .isEnabled
        // If the answerId is equal to the button tag, give it a green border
        // If it's not the answer, lower it's opacity
        // After the loop, check if the answerId is NOT  equal to the sender.tag, and if it's not, set its background color to red via sender.layer.backgroundColor
        [choiceButton1, choiceButton2, choiceButton3].forEach { (button) in
            button?.isEnabled = false
            if answerId == button?.tag {
                button?.backgroundColor = .green
            } else {
                button?.layer.opacity = 0.5
            }
        }
        
        if answerId != sender.tag {
            sender.layer.backgroundColor = UIColor.red.cgColor
        } else {
            Score.shared.userScore = Score.shared.userScore + 1
            scoreLabel.text = "\(Score.shared.userScore)"
        }
    }
    
    @IBAction func closeButton(_ sender: Any) {
    }
    
    @IBAction func choice1Tapped(_ sender: UIButton) {
        GameLogic(sender: sender)
    }
    
    @IBAction func choice2Tapped(_ sender: UIButton) {
        GameLogic(sender: sender)
    }
    
    @IBAction func choice3Tapped(_ sender: UIButton) {
        GameLogic(sender: sender)
    }
    @IBAction func nextQuestionTapped(_ sender: UIButton) {
        updateViews()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
