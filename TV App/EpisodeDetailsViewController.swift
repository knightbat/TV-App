//
//  EpisodeDetailsViewController.swift
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
    var episodeId: Int!
    var episodeDetails: EpisodeDetails!
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ApiMapper.sharedInstance.getEpisodesWithID(epID: episodeId, Success: {(data) -> Void in
            
            self.episodeDetails=data.value(forKey: "data") as! EpisodeDetails
            self.seasonNumberLabel.text=String(format:"Season %d",self.episodeDetails.season!)
            self.episodeNameLabel.text=String(format:"%d - %@",self.episodeDetails.episodeNumber!,self.episodeDetails.episodeName!)
              self.airedDateLabel.text=String(format:"Aired Date : %@",self.episodeDetails.firstAired!)
//            let imagePath : String = "\(ApiMapper.sharedInstance.imageUrl)\(self.episodeDetails.image!)"
//            self.episodeImageView.sd_setImage(with: NSURL (string:imagePath) as URL!, placeholderImage: nil)
            
            self.overViewLabel.text=self.episodeDetails.overView
            
        },Faliure: {(error) -> Void in
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
