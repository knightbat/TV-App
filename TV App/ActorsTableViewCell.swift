//
//  ActorsTableViewCell.swift
//  TV App
//
//  Created by Bindu on 13/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//

import UIKit

class ActorsTableViewCell: UITableViewCell {

    @IBOutlet var actorImageView: UIImageView!
    @IBOutlet var actorNameLabel: UILabel!
    @IBOutlet var actorRoleLabel: UILabel!
   
    @IBOutlet var roleImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
