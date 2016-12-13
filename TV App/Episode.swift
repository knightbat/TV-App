//
//  Episode.swift
//  TV App
//
//  Created by JK on 13/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//
import UIKit
import ObjectMapper

class Episode: Mappable {
    
    var episodeID: Int?
    var absoluteNumber : Int?
    var airedEpisodeNumber : Int?
    var airedSeason : Int?
    var episodeName: String?
    var firstAired: String?
    var overview: String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        episodeID <- map["id"]
        absoluteNumber <- map["absoluteNumber"]
        airedEpisodeNumber <- map["airedEpisodeNumber"]
        airedSeason <- map["airedSeason"]
        episodeName <- map["episodeName"]
        firstAired <- map["firstAired"]
        overview <- map["overview"]
    }
}
