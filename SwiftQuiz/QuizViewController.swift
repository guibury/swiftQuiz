//
//  QuizViewController.swift
//  SwiftQuiz
//
//  Created by Guilherme Bury on 03/02/2018.
//  Copyright © 2018 Guilherme Bury. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    @IBOutlet weak var viewTimer: UILabel!
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet var buttonsAnswers: [UIButton]!
    
    let quizManager = QuizManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewTimer.frame.size.width = view.frame.size.width
        UIView.animate(withDuration: 60, delay: 0, options: .curveLinear, animations: {
            self.viewTimer.frame.size.width = 0
        }) { (success) in
            self.showResults()
        }
        
        getNewQuiz()
    }
    
    func getNewQuiz() {
        quizManager.refreshQuiz()
        labelQuestion.text = quizManager.question
        for i in 0..<quizManager.options.count {
            let option = quizManager.options[i]
            let button = buttonsAnswers[i]
            button.setTitle(option, for: .normal)
        }
    }
    
    @IBAction func selectedAnswer(_ sender: UIButton) {
        let index = buttonsAnswers.index(of: sender)!
        quizManager.validateAnswer(index: index)
        getNewQuiz()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultViewController = segue.destination as! ResultViewController
        resultViewController.totalAnswers = quizManager.totalAnswers
        resultViewController.totalCorrectAnswers = quizManager.totalCorrectAnswers
    }
    
    func showResults() {
        performSegue(withIdentifier: "resultSegue", sender: nil)
        
    }
}
