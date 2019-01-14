//
//  Person.swift
//  TV App
//
//  Created by Bindu on 15/06/17.
//  Copyright © 2017 xminds. All rights reserved.
//

import UIKit
import ObjectMapper

struct Person: Mappable {
    
    var personID: Int?
    var url: String?
    var name: String?
    var image: String?
    var links: String?
    
    init?(map: Map){
        
    }
    
    mutating func mapping(map : Map) {
        
        personID <- map["id"]
        url <- map["url"]
        name <- map["name"]
        image <- map["image.original"]
        links <- map["_links.self.href"]
    }
}
