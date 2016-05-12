//
//  Quiz.swift
//  iQuiz
//
//  Created by Xiaowen Feng on 5/10/16.
//  Copyright © 2016 Xiaowen Feng. All rights reserved.
//

import Foundation

class Quiz {
    var title: String = ""
    var desc: String = ""
    var questions: [Question]
    
    
    init(title: String, desc: String, questions: [Question]) {
        self.title = title
        self.desc = desc
        self.questions = questions
    }
}