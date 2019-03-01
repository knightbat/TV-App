//
//  SeasonEpisodeCollectionViewCell.swift
//  TV App
//
//  Created by Bindu on 19/06/17.
//  Copyright © 2017 xminds. All rights reserved.
//

import UIKit

class SeasonEpisodeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var episodeTableView: UITableView!
    var  seasonEpisodesArray :[Episode] = []
    
    func setupWIth(episodes: [Episode])  {
        seasonEpisodesArray = episodes
        episodeTableView.reloadData()
    }    
}

extension SeasonEpisodeCollectionViewCell: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return seasonEpisodesArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let episode: Episode = seasonEpisodesArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! EpisodeTableViewCell
        cell.setupWith(episode: episode)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
