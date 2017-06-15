
//
//  ApiMapper.swift
//  TV App
//
//  Created by JK on 07/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//
import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class ApiMapper {
    
    //MARK: Shared Instance
    
    static let sharedInstance : ApiMapper = {
        let instance = ApiMapper()
        return instance
    }()
    
    
    let  baseUrl : String
    
    init() {
        baseUrl = "https://api.tvmaze.com"
    }
    
    func getTopRated(params: Parameters, Success:   @escaping ( _ success: NSDictionary) -> Void, Faliure:  @escaping ( _ faliure: NSDictionary) -> Void ) {
        
    }
    
    func getSeries(params: Parameters, Success:   @escaping ( _ success: NSDictionary) -> Void, Faliure:  @escaping ( _ faliure: NSDictionary) -> Void ) {
        
        
        Alamofire.request(baseUrl +  AppData.search, method: .get, parameters: params
            , encoding: URLEncoding.default, headers: nil).responseArray(keyPath: "") { (response: DataResponse<[Series]>) in
                
                if let result = response.result.value {
                    Success(["data":result])
                } else {
                    Faliure(["message" : "result not found"])
                }
        }
    }
    
    
    func getSeasons(seriesID: Int, Success:   @escaping ( _ success: NSDictionary) -> Void, Faliure:  @escaping ( _ faliure: NSDictionary) -> Void ) {
       
        Alamofire.request(baseUrl +  AppData.shows+String(seriesID)+AppData.season, method: .get, parameters: nil
            , encoding: URLEncoding.default, headers: nil).responseArray(keyPath: "") { (response: DataResponse<[Season]>) in
                
                if let result = response.result.value {
                    Success(["data":result])
                } else {
                    Faliure(["message" : "result not found"])
                }
        }

    }
    func getEpisodesDetailsWith(epID: Int, Success: @escaping (_ success: NSDictionary) -> Void, Faliure: @escaping (_ faliure: NSDictionary) -> Void ) {
        let urlString: String = "\(baseUrl)/series/\(epID)/episodes/summary"
        Alamofire.request(urlString, method: .get, parameters: nil
            , encoding: URLEncoding.default, headers: nil).responseObject(keyPath: "data") { (response: DataResponse<SeriesInfo> ) in
                
                
                if let result = response.result.value {
                    Success(["data":result])
                } else {
                    Faliure(["message" : "result not found"])
                }
        }
        
    }
    
    
    func getEpisodeswith(seriesID: Int, seasonNumber: Int, Success: @escaping (_ success: NSDictionary) -> Void, Faliure: @escaping (_ faliure: NSDictionary) -> Void ) {
        
        let params: Parameters = [
            "airedSeason" : seasonNumber
        ]
        
        
        let urlString: String = "\(baseUrl)/series/\(seriesID)/episodes/query"
        Alamofire.request(urlString, method: .get, parameters: params
            , encoding: URLEncoding.default, headers: nil).responseArray(keyPath: "data") { (response: DataResponse<[Episode]>) in
                
                
                if let result = response.result.value {
                    Success(["data":result])
                } else {
                    Faliure(["message" : "result not found"])
                }
        }
        
    }
    
    func getActors( seriesID: Int, Success:   @escaping ( _ success: NSDictionary) -> Void, Faliure:  @escaping ( _ faliure: NSDictionary) -> Void ) {
        
        
        let urlString: String = baseUrl+AppData.shows+String(seriesID)+AppData.cast
        Alamofire.request(urlString, method: .get, parameters: nil
            , encoding: URLEncoding.default, headers: nil).responseArray (keyPath :"") { (response: DataResponse<[Actor]>) in
                
                
                if let result = response.result.value {
                    Success(["data":result])
                } else {
                    Faliure(["message" : "result not found"])
                }
        }
        
    }
    
    func getEpisodesWithID(epID: Int, Success: @escaping (_ success: NSDictionary) -> Void, Faliure: @escaping (_ faliure: NSDictionary) -> Void ) {
        
        let urlString: String = "\(baseUrl)/episodes/\(epID)"
        Alamofire.request(urlString, method: .get, parameters: nil
            , encoding: URLEncoding.default, headers: nil).responseObject(keyPath: "data") { (response: DataResponse<EpisodeDetails> ) in
                
                
                if let result = response.result.value {
                    Success(["data":result])
                } else {
                    Faliure(["message" : "result not found"])
                }
        }
        
    }
    
}
