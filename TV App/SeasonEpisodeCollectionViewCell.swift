//
//  SeasonEpisodeCollectionViewCell.swift
//  TV App
//
//  Created by Bindu on 19/06/17.
//  Copyright © 2017 xminds. All rights reserved.
//

import UIKit

class SeasonEpisodeCollectionViewCell: UICollectionViewCell,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet var episodeTableView: UITableView!
    var  selectedSeasonArray :[Episode] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return selectedSeasonArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let episode: Episode = selectedSeasonArray[indexPath.row]
        
        let cell: EpisodeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! EpisodeTableViewCell
        cell.epName.text = "\( String(format: "%02d", episode.episodeNumber!)) - \(episode.episodeName!)"
        cell.epImageView.sd_setImage(with: NSURL(string: episode.episodeImage ?? AppData.placeholderUrl) as URL!, placeholderImage: nil)
        
        do {
            let myAttribute = [ NSAttributedStringKey.font: UIFont(name: "ChalkboardSE-Regular", size: 14.0)! ,NSAttributedStringKey.foregroundColor:UIColor.white]
            let attrString = try NSMutableAttributedString(data: ((episode.summary ?? "")?.data(using: String.Encoding.unicode,allowLossyConversion: true))!, options: [ NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            attrString.addAttributes(myAttribute, range: NSMakeRange(0, attrString.length))
            cell.epDesc.attributedText = attrString
        } catch let error {
            print(error)
            cell.epDesc.text = episode.summary
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = AppData.dateFormat
        cell.epDate.text = "Aired Date : "+dateFormatter.string(from: episode.airDate!)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
}
