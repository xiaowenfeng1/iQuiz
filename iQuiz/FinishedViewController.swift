//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Xiaowen Feng on 5/11/16.
//  Copyright © 2016 Xiaowen Feng. All rights reserved.
//

import UIKit

class FinishedViewController: UIViewController {
    var questionNum = 0
    var totalScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        setContent()
    }

    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var showResult: UILabel!
    
    func setContent() {
        showResult.text = ("You got \(totalScore) out of \(questionNum) right.")
        let ratio = Double(totalScore / questionNum)
        
        if  ratio == 1.0 {
            header.text = "Congrats, you got a perferct score!"

        } else {
            header.text = "Not too bad, try again!"
        }
        
    }
}
