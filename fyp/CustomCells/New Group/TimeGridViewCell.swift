//
//  TimeGridViewCell.swift
//  fyp
//
//  Created by Rameez Hasan on 10/15/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit
import G3GridView

class TimeGridViewCell: GridViewCell {
    
    @IBOutlet weak var borderView: UIView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    static var nib: UINib {
        return UINib(nibName: "TimeGridViewCell", bundle: Bundle(for: self))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        timeLabel.text = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ TimeName: String) {
        timeLabel.minimumScaleFactor = 0.7
        timeLabel.adjustsFontSizeToFitWidth = true
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = UIColor.black.cgColor
        timeLabel.text = TimeName
    }
    
}
