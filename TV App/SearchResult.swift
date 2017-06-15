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

class SearchResult: Mappable {

    var score: Float?
    var series: Series?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map : Map) {
        
        score <- map["score"]
        series <- map["show"]
       
    }
}
