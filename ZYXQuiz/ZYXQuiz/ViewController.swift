//
//  ViewController.swift
//  ZYXQuiz
//
//  Created by 卓酉鑫 on 16/5/26.
//  Copyright © 2016年 卓酉鑫. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var qustionLabel: UILabel!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    let questions: [String] = ["From what is cognac made?", "What is 7+77", "What is the capital of Vermont"]
    
    let answers: [String] = ["Grapes", "14", "Montpelier"]
    
    var currentQustionIndex: Int = 0
    
    @IBAction func showNextQuestion(sender: AnyObject)
    {
        currentQustionIndex += 1
        if currentQustionIndex == questions.count
        {
            currentQustionIndex = 0
        }
        
        let question: String = questions[currentQustionIndex]
        qustionLabel.text = question
        answerLabel.text = "???"
    }
    
    @IBAction func showAnswer(sender: AnyObject)
    {
        let answer: String = answers[currentQustionIndex]
        answerLabel.text = answer
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        qustionLabel.text = questions[currentQustionIndex]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

