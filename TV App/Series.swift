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

    var score: Float?
    var show: Show?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map : Map) {
        
        score <- map["score"]
        show <- map["show"]
       
    }
}
