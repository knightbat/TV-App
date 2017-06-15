//
//  Season.swift
//  TV App
//
//  Created by Bindu on 15/06/17.
//  Copyright © 2017 xminds. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class Season: Mappable {
    
    var seasonID: Int?
    var url: String?
    var number: Int?
    var name: String?
    var episodeOrder: Int?
    var premiereDate: String?
    var endDate: String?
    var image: String?
    var summary: String?
    var links: String?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map : Map) {
        
        seasonID <- map["id"]
        url <- map["url"]
        number <- map["number"]
        name <- map["name"]
        episodeOrder <- map["episodeOrder"]
        premiereDate <- map["premiereDate"]
        endDate <- map["endDate"]
        image <- map["image.original"]
        summary <- map["summary"]
        links <- map["_links.self.href"]
    }
}
