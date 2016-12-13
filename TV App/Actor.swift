//
//  Actor.swift
//  TV App
//
//  Created by Bindu on 13/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class Actor: Mappable {
    
    var actorID : Int?
    var seriesId : Int?
    var name : String?
    var role : String?
    var sortOrder : Int?
    var image : String?
    var imageAuthor : Int?
    var imageAdded : Date?
    var lastUpdated : Date?
    
    required init?(map: Map){
        
    }
    
    func mapping(map : Map) {
        actorID <- map["id"]
        seriesId <- map["seriesId"]
        name <- map["name"]
        role <- map["role"]
        sortOrder <- map["sortOrder"]
        image <- map["image"]
        imageAuthor <- map["imageAuthor"]
        imageAdded <- map["imageAdded"]
        lastUpdated <- map["lastUpdated"]
    }
}
