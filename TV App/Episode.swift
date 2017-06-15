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
    var episodeURL: String?
    var episodeNumber : Int?
    var airedSeason : Int?
    var episodeName: String?
    var airDate: String?
    var airTime: String?
    var image: String?
    var summary : String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        episodeID <- map["id"]
        episodeURL <- map["url"]
        episodeNumber <- map["number"]
        airedSeason <- map["season"]
        episodeName <- map["name"]
        airDate <- map["airdate"]
        airTime <- map["airtime"]
        image <- map["image.original"]
        summary <- map["summary"]
    }
}
