//
//  ListCollectionViewCell.swift
//  TV App
//
//  Created by Bindu on 16/06/17.
//  Copyright © 2017 xminds. All rights reserved.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var seriesNameLabel: UILabel!
    @IBOutlet var bannerImageView: XMImageView!
    @IBOutlet var ratingLabel: UILabel!
    
    func setupWith(series: Series) {
        bannerImageView?.sd_setImage(with: URL(string: series.image?.original ?? AppData.placeholderUrl), placeholderImage: nil)
        seriesNameLabel.text = series.name
        ratingLabel.text = "\(series.rating?.average ?? 0)"
    }
}
