//
//  Crew.swift
//  TV App
//
//  Created by Bindu on 05/01/18.
//  Copyright © 2018 xminds. All rights reserved.
//

import UIKit
import ObjectMapper

struct Crew: Mappable {
    
    
    var type: String?
    var person:Person?
    
    init?(map: Map){
        
    }
    
    mutating func mapping(map : Map) {
        
        type <- map["type"]
        person <- map["person"]
    }
}
