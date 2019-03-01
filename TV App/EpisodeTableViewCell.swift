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
    @IBOutlet var epDate: UILabel!
    @IBOutlet var epDesc: UILabel!
    @IBOutlet var epImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupWith(episode: Episode) {
        epName.text = String(format: "%02d", episode.episodeNumber ?? 0) + " - " + (episode.episodeName ?? "")
        epImageView.sd_setImage(with: URL(string: episode.image?.original ?? AppData.placeholderUrl), placeholderImage: nil)
        
        do {
            let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "ChalkboardSE-Regular", size: 14.0)! ,NSAttributedString.Key.foregroundColor:UIColor.white]
            let attrString = try NSMutableAttributedString(data: ((episode.summary ?? "")?.data(using: String.Encoding.unicode,allowLossyConversion: true))!, options: [ NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            attrString.addAttributes(myAttribute, range: NSMakeRange(0, attrString.length))
            epDesc.attributedText = attrString
        } catch let error {
            print(error)
            epDesc.text = episode.summary
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = AppData.dateFormatApi
        let date = dateFormatter.date(from:  episode.airdate!)
        dateFormatter.dateFormat = AppData.dateFormat
        epDate.text = "Aired Date : "+dateFormatter.string(from: date!)
    }
}
