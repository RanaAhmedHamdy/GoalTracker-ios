//
//  GoalCell.swift
//  goalPost-app
//
//  Created by Hazem Mohamed Magdy on 11/29/17.
//  Copyright © 2017 Rana. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalLength: UILabel!
    @IBOutlet weak var goalType: UILabel!
    @IBOutlet weak var goalTxt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(goal: String, goalType: GoalType, goalProgress: Int) {
        goalTxt.text = goal
        self.goalType.text = goalType.rawValue
        goalLength.text = String(describing: goalProgress)
    }

}
