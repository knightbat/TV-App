//
//  SeasonsCollectionViewCell.swift
//  TV App
//
//  Created by JK on 13/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//

import UIKit

class SeasonsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var seasonLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        seasonLabel.layer.cornerRadius = seasonLabel.frame.size.height/2
    }

}
