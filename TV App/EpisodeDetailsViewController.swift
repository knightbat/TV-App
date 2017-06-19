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
    var episode: Episode!
    var seriesImage: String!
    
    @IBOutlet var urlButton: UIButton!
    @IBOutlet var runTimeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.seasonNumberLabel.text=String(format:"Season %d",self.episode.airedSeason!)
        self.episodeNameLabel.text=String(format:"%d - %@",self.episode.episodeNumber!,self.episode.episodeName!)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  AppData.dateFormat
        self.airedDateLabel.text=String(format:"Aired Date : %@", dateFormatter.string(from: self.episode.airDate! ))
        
        self.bgImage.sd_setImage(with: NSURL (string: self.episode.episodeImage ?? seriesImage) as URL!, placeholderImage: nil)
        self.episodeImageView.sd_setImage(with: NSURL (string: self.episode.episodeImage ?? AppData.placeholderUrl) as URL!, placeholderImage: nil)
        
        do {
            let myAttribute = [ NSFontAttributeName: UIFont(name: "ChalkboardSE-Regular", size: 14.0)! ,NSForegroundColorAttributeName:UIColor.white]
            let attrString = try NSMutableAttributedString(data: ((episode.summary ?? "")?.data(using: String.Encoding.unicode,allowLossyConversion: true))!, options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            attrString.addAttributes(myAttribute, range: NSMakeRange(0, attrString.length))
            self.overViewLabel.attributedText = attrString
        } catch let error {
            print(error)
            self.overViewLabel.text = episode.summary
        }
        runTimeLabel.text = "\(episode.runtime ?? 0) min"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Other Methods
    
    
    @IBAction func urlBtnClicked(_ sender: UIButton) {
        
        let url = NSURL(string: episode.url!)!
        
        if !UIApplication.shared.openURL(url as URL) {
            print("Failed to open url :"+url.description)
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
