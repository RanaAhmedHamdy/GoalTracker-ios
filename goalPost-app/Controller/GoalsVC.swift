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
    var goals: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalsTableview.delegate = self
        goalsTableview.dataSource = self
        
        goalsTableview.isHidden = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchCoreData()
        goalsTableview.reloadData()
    }
    
    func fetchCoreData() {
        fetch { (complete) in
            print("complete: \(complete)")
            if complete {
                if goals.count >= 1 {
                    goalsTableview.isHidden = false
                } else {
                    goalsTableview.isHidden = true
                }
            }
        }
    }
    
    @IBAction func unwindToGoalsVC(segue: UIStoryboardSegue) {}

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
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as? GoalCell {
            let goal = goals[indexPath.row]
            cell.configureCell(goal: goal)
            return cell
        }
        return GoalCell()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (tableViewRowAction, indexPath) in
            self.removeGoal(indexPath: indexPath)
            self.fetchCoreData()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (tableViewRowAction, indexPath) in
            self.setGoalProgress(indexpath: indexPath)
            self.goalsTableview.reloadRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 1, green: 0.5824048568, blue: 0.1282368232, alpha: 1)
        
        return [deleteAction, addAction]
    }
}

extension GoalsVC {
    func setGoalProgress(indexpath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}

        let chosenGoal = goals[indexpath.row]
        
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgress += 1
        } else {
            return
        }
        
        do {
            try managedContext.save()
            print("successfully set successfully!")
        } catch {
            debugPrint("cannot set progress: \(error.localizedDescription)")
        }
    }
    
    func removeGoal(indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        managedContext.delete(goals[indexPath.row])
        
        do {
            try managedContext.save()
            print("successfully removed!")
        } catch {
            debugPrint("cannot delete: \(error.localizedDescription)")
        }
    }
    func fetch(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            goals = try managedContext.fetch(fetchRequest)
            print("successfully fetched!")
            completion(true)
        } catch {
            debugPrint("cannot fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
}

