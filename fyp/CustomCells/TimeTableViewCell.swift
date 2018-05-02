//
//  TimeTableViewCell.swift
//  fyp
//
//  Created by Rameez Hasan on 12/22/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit

class TimeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var teacherNameLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var teacherValueLabel: UILabel!
    @IBOutlet weak var courseValueLabel: UILabel!
    @IBOutlet weak var timeValueLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationValueLabel: UILabel!
    @IBOutlet weak var dayValueLabel: UILabel!
    @IBOutlet weak var sectionValueLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
