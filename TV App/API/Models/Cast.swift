//
//  Actor.swift
//  TV App
//
//  Created by Bindu on 13/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//

import UIKit
import ObjectMapper

struct Cast: Mappable {
    
    var actor : Person?
    var character : Person?
    
    init?(map: Map){
        
    }
    
    mutating func mapping(map : Map) {
        actor <- map["person"]
        character <- map["character"]
    }
}
