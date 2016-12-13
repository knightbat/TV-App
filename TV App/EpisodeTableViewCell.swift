//
//  EpisodeTableViewCell.swift
//  TV App
//
//  Created by JK on 13/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {

    @IBOutlet var epName: UILabel!
    @IBOutlet var epImage: UIImageView!
    @IBOutlet var epDesc: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
