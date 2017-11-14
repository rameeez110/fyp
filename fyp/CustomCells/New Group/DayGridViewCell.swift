//
//  DayGridViewCell.swift
//  fyp
//
//  Created by Rameez Hasan on 10/15/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit
import G3GridView

class DayGridViewCell: GridViewCell {
    
    @IBOutlet weak var borderView: UIView!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var sectionALabel: UILabel!
    @IBOutlet weak var sectionBLabel: UILabel!
    
    static var nib: UINib {
        return UINib(nibName: "DayGridViewCell", bundle: Bundle(for: self))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dayLabel.text = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ dayInt: Int) {
//        dayLabel.text = dayName
        dayLabel.minimumScaleFactor = 0.7
        dayLabel.adjustsFontSizeToFitWidth = true
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = UIColor.black.cgColor
        if dayInt == 0
        {
            dayLabel.text = "Monday"
        }
        else if dayInt == 1
        {
            dayLabel.text = "Tuesday"
        }
        else if dayInt == 2
        {
            dayLabel.text = "Wednesday"
        }
        else if dayInt == 3
        {
            dayLabel.text = "Thursday"
        }
        else{
            dayLabel.text = "Friday"
        }
        sectionALabel.text = "A"
        sectionBLabel.text = "B"
    }
    
}
