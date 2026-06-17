//
//  CustomTableViewCell.swift
//  Workout APP
//
//  Created by Mansi Kale on 17/06/26.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var workoutimage: UIImageView!
    
    @IBOutlet weak var workoutName: UILabel!
    
    @IBOutlet weak var workoutTime: UILabel!
    
    @IBOutlet weak var workoutInfo: UILabel!
    
    @IBOutlet weak var workoutDuration: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
