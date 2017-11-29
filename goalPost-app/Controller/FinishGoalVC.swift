//
//  FinishGoalVC.swift
//  goalPost-app
//
//  Created by Hazem Mohamed Magdy on 11/29/17.
//  Copyright © 2017 Rana. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var goalPointsTxt: UITextField!
    @IBOutlet weak var createGoalBtn: UIButton!
    
    var goalType: GoalType!
    var goalDescription: String!
    
    func initData(description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createGoalBtn.bindToKeyboard()
        goalPointsTxt.delegate = self
    }
    @IBAction func createGoalBtnPressed(_ sender: Any) {
        if goalPointsTxt.text != "" {
            self.save { (complete) in
                if complete {
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func save(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(goalPointsTxt.text!)!
        goal.goalProgress = Int32(0)
        
        do {
            try managedContext.save()
            print("Successfully saved data.")
            completion(true)
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
    }
}
