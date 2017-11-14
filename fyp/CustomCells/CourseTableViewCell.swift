//
//  CourseTableViewCell.swift
//  fyp
//
//  Created by Rameez Hasan on 10/29/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit

class CourseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var courseNumberLabel: UILabel!
    @IBOutlet weak var courseCreditHourLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
