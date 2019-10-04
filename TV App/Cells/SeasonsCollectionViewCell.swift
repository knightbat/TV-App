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
        seasonLabel.layer.cornerRadius = seasonLabel.frame.size.height/2
    }
    
    func setupCell(withSeasonNumber seasonNumber : String, andSelectStatus isSelected : Bool = false) {
        self.seasonLabel.text = seasonNumber
        self.seasonLabel.backgroundColor = isSelected ? UIColor.brown : UIColor.gray
    }
}
