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
    var airDate: Date?
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
        image <- map["image.original"]
        summary <- map["summary"]
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let dateString = map["airDate"].currentValue as? String, let _date = dateFormatter.date(from: dateString) {
            airDate = _date
        }
    }
}
