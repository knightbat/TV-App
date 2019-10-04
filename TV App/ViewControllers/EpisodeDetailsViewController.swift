//
//  episodeViewController.swift
//  TV App
//
//  Created by Bindu on 14/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//

import UIKit

class EpisodeDetailsViewController: UIViewController {
    
    @IBOutlet var overViewLabel: UILabel!
    @IBOutlet var seasonNumberLabel: UILabel!
    @IBOutlet var episodeNameLabel: UILabel!
    @IBOutlet var airedDateLabel: UILabel!
    @IBOutlet var episodeImageView: UIImageView!
    @IBOutlet var bgImage: UIImageView!
    @IBOutlet var seriesNameLabel: UILabel!
    
    var episode: Episode!
    var seriesImage: String!
    var seriesName: String!
    
    @IBOutlet var urlButton: UIButton!
    @IBOutlet var runTimeLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setupUI()
        
    }
    
    func setupUI() {
        seriesNameLabel.text = seriesName
        self.seasonNumberLabel.text=String(format:"Season : %d",self.episode.airedSeason!)
        self.episodeNameLabel.text=String(format:"%d - %@",self.episode.episodeNumber!,self.episode.episodeName!)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  AppData.dateFormatApi
        let date = dateFormatter.date(from: self.episode.airdate!)
        dateFormatter.dateFormat =  AppData.dateFormat
        self.airedDateLabel.text=String(format:"Aired Date : %@", dateFormatter.string(from: date! ))
        
        self.bgImage.sd_setImage(with: URL(string: self.episode.image?.original ?? seriesImage), placeholderImage: nil)
        self.episodeImageView.sd_setImage(with: URL(string: self.episode.image?.original ?? AppData.placeholderUrl), placeholderImage: nil)
        
        do {
            let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "ChalkboardSE-Regular", size: 14.0)! ,NSAttributedString.Key.foregroundColor:UIColor.white]
            let attrString = try NSMutableAttributedString(data: ((episode.summary ?? "")?.data(using: String.Encoding.unicode,allowLossyConversion: true))!, options: [ NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            attrString.addAttributes(myAttribute, range: NSMakeRange(0, attrString.length))
            self.overViewLabel.attributedText = attrString
        } catch let error {
            print(error)
            self.overViewLabel.text = episode.summary
        }
        runTimeLabel.text = "\(episode.runtime ?? 0) min"
        
        let url = NSAttributedString(string: (episode.links?.linkSelf?.href!)!)
        urlButton.setAttributedTitle(url, for: UIControl.State.normal)
    }
    
    // MARK: - IBActions
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func urlBtnClicked(_ sender: UIButton) {
        
        guard let urlString = episode.links?.linkSelf?.href else {
            return
        }
        let url: URL! = URL(string: urlString)
        if !UIApplication.shared.openURL(url) {
            print("Failed to open url :"+url.description)
        }
    }
}
