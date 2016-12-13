//
//  SeriesInfo.swift
//  TV App
//
//  Created by JK on 13/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class SeriesInfo: Mappable {

    var airedSeasons:  [String]?
    var airedEpisodes: String?
    
    required init?(map: Map) {
        
    }
    
    
    func mapping(map: Map) {
        
        airedSeasons <- map["airedSeasons"]
        airedEpisodes <- map["airedEpisodes"]

    }
}
