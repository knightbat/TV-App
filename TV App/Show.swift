//
//  Show.swift
//  TV App
//
//  Created by Bindu on 15/06/17.
//  Copyright © 2017 xminds. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class Show: Mappable {
    
    var seriesID: Int?
    var seriesURL: String?
    var name: String?
    var status: String?
    var runtime: Int?
    var premiered: String?
    var officialSite: String?
    var rating: Float?
    var summary: String?
    var image: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map : Map) {
        
        seriesID <- map["id"]
        seriesURL <- map["url"]
        name <- map["name"]
        status <- map["status"]
        runtime <- map["runtime"]
        premiered <- map["premiered"]
        officialSite <- map["officialSite"]
        rating <- map["rating.average"]
        summary <- map["summary"]
        image <- map["image.original"]

    }
}
