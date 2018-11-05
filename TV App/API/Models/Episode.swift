//
//  Episode.swift
//  TV App
//
//  Created by JK on 13/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//

import UIKit
import ObjectMapper

struct Episode: Mappable {
    
    var episodeID: Int?
    var episodeURL: String?
    var episodeNumber : Int?
    var airedSeason : Int?
    var episodeName: String?
    var airDate: Date?
    var episodeImage: String?
    var summary : String?
    var url : String?
    var runtime : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        episodeID <- map["id"]
        episodeURL <- map["url"]
        episodeNumber <- map["number"]
        airedSeason <- map["season"]
        episodeName <- map["name"]
        episodeImage <- map["image.original"]
        summary <- map["summary"]
        url <- map["url"]
        runtime <- map["runtime"]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let dateString = map["airdate"].currentValue as? String, let _date = dateFormatter.date(from: dateString) {
            airDate = _date
        }
    }
}
