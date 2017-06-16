//
//  EpisodesViewController.swift
//  TV App
//
//  Created by JK on 13/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//
import UIKit

class EpisodesViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet var episodeTableView: UITableView!
    @IBOutlet var seasonLabel: UILabel!
    @IBOutlet var bgImage: UIImageView!
    
    var seriesID: Int!
    var seasonIndex: Int!
    var episodeArray: [Episode] = []
    var imageUrl: String!
    var seasonArray: [Season] = []
    var filteredArray:[Episode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let season : Season = self.seasonArray[self.seasonIndex]
        self.seasonLabel.text =  "Season : \(season.number ?? 0)"
        if (imageUrl != nil) {
            self.bgImage?.sd_setImage(with: NSURL(string: imageUrl ) as URL!, placeholderImage: nil)
        }
        ApiMapper.sharedInstance.getEpisodeswith(seriesID: seriesID, seasonNumber: seasonIndex
            , Success: {(dataDict) -> Void in
                
                self.episodeArray = dataDict.value(forKey: "data") as! [Episode]
                self.filteredArray = self.episodeArray.filter {$0.airedSeason==season.number};
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
        
        return filteredArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let episode: Episode = filteredArray[indexPath.row]
        
        let cell: EpisodeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! EpisodeTableViewCell
        cell.epName.text = "\( String(format: "%02d", episode.episodeNumber!)) - \(episode.episodeName!)"
        cell.epDesc.text = episode.summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        
        let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy-MM-dd"
        cell.epDate.text = "Aired Date : "+dateFormatter.string(from: episode.airDate!)
        
        return cell
        
    }
    
    // MARK: - CollectionView Delegates and Datasources
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.seasonArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: SeasonsCollectionViewCell = collectionView .dequeueReusableCell(withReuseIdentifier: "season", for: indexPath) as! SeasonsCollectionViewCell
        
        let season : Season = self.seasonArray[indexPath.row]
        cell.seasonLabel.text = "\(season.number ?? 0)"
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let season : Season = self.seasonArray[indexPath.row]
        self.seasonLabel.text =  "Season : \(season.number ?? 0)"
        
        imageUrl = season.image
        if (imageUrl != nil) {
            self.bgImage?.sd_setImage(with: NSURL(string: imageUrl ) as URL!, placeholderImage: nil)
        }
        
        self.filteredArray = self.episodeArray.filter {$0.airedSeason==season.number};
        collectionView.reloadData()
        episodeTableView.reloadData()
    }
}
