//
//  DataGridViewCell.swift
//  fyp
//
//  Created by Rameez Hasan on 10/15/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit
import G3GridView

class DataGridViewCell: GridViewCell {
    
    @IBOutlet weak var lunchSeparatorTopView: UIView!
    @IBOutlet weak var lunchSeparatorBottomView: UIView!
    @IBOutlet weak var borderView: UIView!
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var lunchLabel: UILabel!
    
    static var nib: UINib {
        return UINib(nibName: "DataGridViewCell", bundle: Bundle(for: self))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dataLabel.text = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ cellData: String) {
        dataLabel.minimumScaleFactor = 0.7
        dataLabel.adjustsFontSizeToFitWidth = true
        borderView.layer.borderWidth = 0.5
        borderView.layer.borderColor = UIColor.black.cgColor
        dataLabel.text = cellData
    }

}
