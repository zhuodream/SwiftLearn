//
//  ViewController.swift
//  ZYXQuiz
//
//  Created by 卓酉鑫 on 16/5/26.
//  Copyright © 2016年 卓酉鑫. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currentQuestionLabel: UILabel!
    @IBOutlet weak var nextQuestionLabel: UILabel!
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
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
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        
        animateLabelTransitions()
    }
    
    @IBAction func showAnswer(sender: AnyObject)
    {
        let answer: String = answers[currentQustionIndex]
        answerLabel.text = answer
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentQuestionLabel.text = questions[currentQustionIndex]
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        nextQuestionLabel.alpha = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func animateLabelTransitions()
    {
        view.layoutIfNeeded()
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        
        UIView.animateWithDuration(0.5, delay: 0, options: [.CurveLinear], animations: {
            self.currentQuestionLabel.alpha = 0
            self.nextQuestionLabel.alpha = 1
            self.view.layoutIfNeeded()
            }) { (_) in
                swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
                swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
                
                self.updateOffScreenLabel()
        }
    }
    
    func updateOffScreenLabel()
    {
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
        
    }
}

