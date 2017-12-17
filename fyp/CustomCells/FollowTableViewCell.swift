//
//  FollowTableViewCell.swift
//  fyp
//
//  Created by Rameez Hasan on 10/23/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit

class FollowTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    
    @IBOutlet weak var followButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
