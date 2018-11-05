//
//  Series.swift
//  TV App
//
//  Created by JK on 12/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//

import UIKit
import ObjectMapper

struct SearchResult: Mappable {

    var score: Float?
    var series: Series?
    
    
    init?(map: Map){
        
    }
    
    mutating func mapping(map : Map) {
        
        score <- map["score"]
        series <- map["show"]
    }
}
