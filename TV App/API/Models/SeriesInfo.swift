//
//  SeriesInfo.swift
//  TV App
//
//  Created by JK on 13/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//

import UIKit
import ObjectMapper

struct SeriesInfo: Mappable {

    var airedSeasons:  [String]?
    var airedEpisodes: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        airedSeasons <- map["airedSeasons"]
        airedEpisodes <- map["airedEpisodes"]
    }
}
