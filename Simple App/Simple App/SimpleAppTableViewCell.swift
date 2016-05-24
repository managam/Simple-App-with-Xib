//
//  SimpleAppTableViewCell.swift
//  Simple App
//
//  Created by Admin on 5/24/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import UIKit

class SimpleAppTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
