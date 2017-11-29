//
//  CreateGoalVC.swift
//  goalPost-app
//
//  Created by Hazem Mohamed Magdy on 11/29/17.
//  Copyright © 2017 Rana. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController, UITextViewDelegate {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var createGoalTxt: UITextView!
    @IBOutlet weak var nextBtn: UIButton!
    
    var goalType: GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createGoalTxt.delegate = self
        nextBtn.bindToKeyboard()
        
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    @IBAction func nextBtnPressed(_ sender: Any) {
        if createGoalTxt.text != "" && createGoalTxt.text != "What is your goal today?" {
            guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "finishGoalVC") as? FinishGoalVC else {return}
            
            finishGoalVC.initData(description: createGoalTxt.text!, type: goalType)
            presentDetail(finishGoalVC)
        }
    }
    @IBAction func shortTermBtnPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
    }
    @IBAction func longTermBtnPressed(_ sender: Any) {
        goalType = .longTerm
        longTermBtn.setSelectedColor()
        shortTermBtn.setDeselectedColor()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        createGoalTxt.text = ""
        createGoalTxt.textColor = UIColor.black
    }
}
