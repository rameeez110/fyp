//
//  AnnouncementTableViewCell.swift
//  fyp
//
//  Created by Rameez Hasan on 10/23/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit

class AnnouncementTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var pofilePicImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
