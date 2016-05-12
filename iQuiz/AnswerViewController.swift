//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Xiaowen Feng on 5/10/16.
//  Copyright © 2016 Xiaowen Feng. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {

    var quiz = Quiz(title: "", desc: "", questions: [])
    var chosenIndex : String = ""
    var questionNum = 0
    var score = 0
    
    @IBOutlet weak var Qlabel: UILabel!

    @IBOutlet var AnswerButtons: [UIButton]!

    @IBOutlet weak var showMessage: UILabel!
    
    @IBOutlet weak var showAnswer: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        setContent()
    }
    
    func setContent() {
        Qlabel.text = quiz.questions[questionNum].question
        showMessage.textColor = UIColor.blueColor()
        
        showAnswers()
    }
    
    func showAnswers() {
        let correctNum = Int(quiz.questions[questionNum].answer)! - 1
        let correctAns = quiz.questions[questionNum].answers[correctNum]
        if chosenIndex == quiz.questions[questionNum].answer {
            showMessage.text = "Congrats! You got it right."
            showAnswer.text = "Answer: \(correctAns)"
            
            score += 1
            
        } else {
            let yourAns = quiz.questions[questionNum].answers[Int(chosenIndex)! - 1]
            showMessage.text = "Opps, the answer is incorrect"
             showAnswer.text = "You Answer: \(yourAns) \nCorrect Answer: \(correctAns)"
            
        }
        questionNum += 1
       
    }
    
    @IBAction func showNext(sender: AnyObject) {
        if (quiz.questions.count > questionNum) {
            self.performSegueWithIdentifier("next", sender: self)
            
        } else {
            self.performSegueWithIdentifier("showFinished", sender: self)
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "showFinished" {
            
            let dispayFinished: FinishedViewController = segue.destinationViewController as! FinishedViewController
            dispayFinished.questionNum = questionNum
            dispayFinished.totalScore = score

            
        } else { // =="showFinished"
            let displayQuestion: QuestionViewController = segue.destinationViewController as! QuestionViewController
            displayQuestion.quiz = quiz
            displayQuestion.questionNum = questionNum
            displayQuestion.score = score
        }
        
    }
 

}
