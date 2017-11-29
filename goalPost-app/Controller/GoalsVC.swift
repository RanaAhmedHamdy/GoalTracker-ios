//
//  ViewController.swift
//  goalPost-app
//
//  Created by Hazem Mohamed Magdy on 11/29/17.
//  Copyright © 2017 Rana. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController{

    @IBOutlet weak var goalsTableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalsTableview.delegate = self
        goalsTableview.dataSource = self
        
        goalsTableview.isHidden = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addGoalBtnPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "createGoalVC") else {return}
        presentDetail(createGoalVC)
    }
    
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as? GoalCell {
            cell.configureCell(goal: "s", goalType: .shortTerm, goalProgress: 1)
            return cell
        }
        return UITableViewCell()
    }
}

