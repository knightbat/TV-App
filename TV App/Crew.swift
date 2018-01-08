//
//  Crew.swift
//  TV App
//
//  Created by Bindu on 05/01/18.
//  Copyright © 2018 xminds. All rights reserved.
//

import UIKit

import AlamofireObjectMapper
import ObjectMapper

class Crew: Mappable {
    
    
    var type: String?
    var person:Person?
    
    required init?(map: Map){
        
    }
    
    func mapping(map : Map) {
        
        type <- map["type"]
        person <- map["person"]
        
    }
}
