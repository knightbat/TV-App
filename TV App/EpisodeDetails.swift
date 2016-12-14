//
//  EpisodeDetails.swift
//  TV App
//
//  Created by Bindu on 14/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//

import UIKit
import ObjectMapper

class EpisodeDetails: Mappable {
    
    var episodeID: Int?
    var season: Int?
    var seasonID: Int?
    var episodeNumber: Int?
    var episodeName: String?
    var firstAired: String?
    var guestStars: [String]?
    var director: String?
    var directors: [String]?
    var writers: [String]?
    var overView: String?
    var image: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        episodeID <- map["id"]
        season <- map["airedSeason"]
        seasonID <- map["airedSeasonID"]
        episodeNumber <- map["airedEpisodeNumber"]
        episodeName <- map["episodeName"]
        firstAired <- map["firstAired"]
        guestStars <- map["guestStars"]
        director <- map["director"]
        directors <- map["directors"]
        writers <- map["writers"]
        overView <- map["overview"]
        image <- map["filename"]
    }
}
