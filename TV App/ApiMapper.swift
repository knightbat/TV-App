//
//  ApiMapper.swift
//  TV App
//
//  Created by JK on 07/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//

import UIKit
import Alamofire

class ApiMapper {
    
    //MARK: Shared Instance
    
    static let sharedInstance : ApiMapper = {
        let instance = ApiMapper()
        return instance
    }()
    
    
    let  baseUrl : String
    let  imageUrl : String
    var token : String
    
    init() {
        baseUrl = "https://api.thetvdb.com"
        token = ""
        imageUrl = "https://thetvdb.com/banners/"
    }
    
    // MARK: GET TOKENS

    func getToken(params: Parameters, Success:   @escaping ( _ success: NSDictionary) -> Void, Faliure:  @escaping ( _ faliure: NSDictionary) -> Void ) {
        
        
        Alamofire.request(baseUrl + "/login", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
            
            if let result = response.result.value {
                let json = result as! NSDictionary
                if (json.object(forKey: "token") != nil) {
                    self.token = json.object(forKey: "token") as! String
                    Success(["data" : "ok"])
                } else {
                    Faliure(["message" : json.object(forKey: "Error") as! String])
                }
            }
        }
    }
    
    func getSeries(params: Parameters, Success:   @escaping ( _ success: NSDictionary) -> Void, Faliure:  @escaping ( _ faliure: NSDictionary) -> Void ) {
        
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " +  self.token,
            "Accept": "application/json"
        ]
        
        
        Alamofire.request(baseUrl +  "/search/series", method: .get, parameters: params
            , encoding: URLEncoding.default, headers: headers).responseJSON { response in
                
                if let result = response.result.value {
                    let json = result as! NSDictionary
                    if ((json.object(forKey: "data")) != nil) {
                        Success(json)
                    } else {
                        Faliure(["message" : json.object(forKey: "Error") as! String])
                    }
                }
        }
        
    }
}