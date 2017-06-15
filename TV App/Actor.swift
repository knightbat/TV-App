//
//  Actor.swift
//  TV App
//
//  Created by Bindu on 13/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class Actor: Mappable {
    
    var actor : Person?
    var character : Person?
    
    required init?(map: Map){
        
    }
    
    func mapping(map : Map) {
        actor <- map["person"]
        character <- map["character"]
    }
}
