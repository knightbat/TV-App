//
//  Series.swift
//  TV App
//
//  Created by JK on 12/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class Series: Mappable {

    var banner: String?
    var seriesId: Int?
    var network: String?
    var overview: String?
    var seriesName: String?
    var status: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map : Map) {
        
        banner <- map["banner"]
        seriesId <- map["id"]
        network <- map["network"]
        overview <- map["overview"]
        seriesName <- map["seriesName"]
        status <- map["status"]
    }
}
