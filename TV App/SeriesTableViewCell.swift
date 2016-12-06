//
//  SeriesTableViewCell.swift
//  TV App
//
//  Created by JK on 07/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//

import UIKit

class SeriesTableViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var bannerImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
