//
//  AttachmentTableViewCell.swift
//  fyp
//
//  Created by Rameez Hasan on 10/23/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit

class AttachmentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var pofilePicImageView: UIImageView!
    @IBOutlet weak var attachmentImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
