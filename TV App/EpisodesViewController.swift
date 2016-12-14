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
    
    var seriesID: Int!
    var seasonNumber: Int!
    var episodeArray: [Episode] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.seasonLabel.text =  "Season : \(self.seasonNumber!)"
        ApiMapper.sharedInstance.getEpisodeswith(seriesID: seriesID, seasonNumber: seasonNumber
            , Success: {(dataDict) -> Void in
                
                self.episodeArray = dataDict.value(forKey: "data") as! [Episode]
                
                self.episodeTableView.estimatedRowHeight = 70 // for example. Set your average height
                self.episodeTableView.rowHeight = UITableViewAutomaticDimension
                self.episodeTableView.reloadData()
        }, Faliure: {(error) -> Void in
            
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return episodeArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let episode: Episode = episodeArray[indexPath.row]
        
        let cell: EpisodeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! EpisodeTableViewCell
        cell.epName.text = episode.episodeName
        cell.epDesc.text = episode.overview
        cell.epDate.text = "Aired Date : \(episode.firstAired!)"
        return cell
        
    }
}
