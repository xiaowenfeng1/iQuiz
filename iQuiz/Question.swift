//
//  Question.swift
//  iQuiz
//
//  Created by Xiaowen Feng on 5/10/16.
//  Copyright © 2016 Xiaowen Feng. All rights reserved.
//

import Foundation

class Question {
    var question: String = ""
    var answer: String = ""
    var answers: [String]
    
    init(question: String, answer: String, answers: [String]) {
        self.question = question
        self.answer = answer
        self.answers = answers
    }
}