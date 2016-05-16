//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Xiaowen Feng on 5/10/16.
//  Copyright © 2016 Xiaowen Feng. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var Qlabel: UILabel!
    
    @IBOutlet var AnswerButtons: [UIButton]!
    
    @IBOutlet weak var Submit: UIButton!
    var chosenIndex : String = ""
    
    var score = 0
    
    var quiz = Quiz(title: "", desc: "", questions: [])
    var questionNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        setContent()
    }
    

    func setContent() {
        Qlabel.text = quiz.questions[questionNum].question
       
        for index in 0..<AnswerButtons.count {
            AnswerButtons[index].backgroundColor = UIColor.clearColor()
            AnswerButtons[index].layer.cornerRadius = 5
            AnswerButtons[index].layer.borderWidth = 0.5
            AnswerButtons[index].layer.borderColor = UIColor.grayColor().CGColor
            AnswerButtons[index].setTitle(quiz.questions[questionNum].answers[index], forState: UIControlState.Normal)
          
        }
    }
    
    @IBAction func chooseAnswer(sender: UIButton) {
         Submit.hidden = false
        let chosenAnswer = sender.currentTitle!
        for index in 0..<AnswerButtons.count {
            
            // disable the unselected buttons
            if AnswerButtons[index] != sender {
                AnswerButtons[index].enabled = false
                AnswerButtons[index].setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            } else {
                AnswerButtons[index].setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
                
            }
            
            if AnswerButtons[index].currentTitle == chosenAnswer {
                chosenIndex = String(index + 1)
            }
        }
    }
 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let displayAnswer: AnswerViewController = segue.destinationViewController as! AnswerViewController
        displayAnswer.quiz = quiz
        displayAnswer.chosenIndex = chosenIndex
        displayAnswer.questionNum = questionNum
        displayAnswer.score = score
    }
 

    

}