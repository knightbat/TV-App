//
//  EpisodesViewController.swift
//  TV App
//
//  Created by JK on 13/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//
import UIKit

class EpisodesViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var episodeTableView: UITableView!
    @IBOutlet var seasonLabel: UILabel!
    @IBOutlet var bgImage: UIImageView!
    
    var seriesID: Int!
    var seasonNumber: Int!
    var episodeArray: [Episode] = []
    var imageUrl: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.seasonLabel.text =  "Season : \(self.seasonNumber!)"
        self.bgImage?.sd_setImage(with: NSURL(string: imageUrl ) as URL!, placeholderImage: nil)
        ApiMapper.sharedInstance.getEpisodeswith(seriesID: seriesID, seasonNumber: seasonNumber
            , Success: {(dataDict) -> Void in
                
                self.episodeArray = dataDict.value(forKey: "data") as! [Episode]
                
                self.episodeTableView.estimatedRowHeight = 70
                self.episodeTableView.rowHeight = UITableViewAutomaticDimension
                self.episodeTableView.reloadData()
        }, Faliure: {(error) -> Void in
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
//        SubmittedBookingViewController *vc=[segue destinationViewController];
        let vc:EpisodeDetailsViewController=segue.destination as! EpisodeDetailsViewController
        let episode: Episode = episodeArray[(episodeTableView.indexPathForSelectedRow?.row)!]

        vc.episodeId=episode.episodeID
      
     }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return episodeArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let episode: Episode = episodeArray[indexPath.row]
        
        let cell: EpisodeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! EpisodeTableViewCell
        cell.epName.text = "\( String(format: "%02d", episode.airedEpisodeNumber!)) - \(episode.episodeName!)"
        cell.epDesc.text = episode.overview
        cell.epDate.text = "Aired Date : \(episode.firstAired!)"
        return cell
        
    }
    
   
}
