
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
    
    func getAllSeries(withParams params: Parameters, callback: @escaping ( _ result: Result) -> Void){
        
        Alamofire.request(baseUrl +  AppData.show, method: .get, parameters: params
            , encoding: URLEncoding.default, headers: nil).responseArray(keyPath: "") { (response: DataResponse<[Series]>) in
                
                if let result = response.result.value {
                    callback(Result(error: nil, data: result))
                } else {
                    callback(Result(error: nil, data: nil))
                }
        }
    }
    
    func searchSeries(params: Parameters, callback: @escaping ( _ result: Result) -> Void){
        
        Alamofire.request(baseUrl +  AppData.search, method: .get, parameters: params
            , encoding: URLEncoding.default, headers: nil).responseArray(keyPath: "") { (response: DataResponse<[SearchResult]>) in
                
                if let result = response.result.value {
                    callback(Result(error: nil, data: result))
                } else {
                    callback(Result(error: nil, data: nil))
                }
        }
    }
    
    
    func getSeasons(seriesID: Int, callback:   @escaping ( _ result: Result) -> Void) {
        
        Alamofire.request(baseUrl +  AppData.shows+String(seriesID)+AppData.season, method: .get, parameters: nil
            , encoding: URLEncoding.default, headers: nil).responseArray(keyPath: "") { (response: DataResponse<[Season]>) in
                
                if let result = response.result.value {
                    callback(Result(error: nil, data: result))
                } else {
                    callback(Result(error: nil, data: nil))
                }
        }
        
    }
    func getEpisodesDetailsWith(epID: Int, callback:   @escaping ( _ result: Result) -> Void) {
        
        let urlString: String = "\(baseUrl)/series/\(epID)/episodes/summary"
        Alamofire.request(urlString, method: .get, parameters: nil
            , encoding: URLEncoding.default, headers: nil).responseObject(keyPath: "data") { (response: DataResponse<SeriesInfo> ) in
                
                if let result = response.result.value {
                    callback(Result(error: nil, data: result))
                } else {
                    callback(Result(error: nil, data: nil))
                }
        }
        
    }
    
    
    func getEpisodeswith(seriesID: Int, seasonNumber: Int, callback:   @escaping ( _ result: Result) -> Void) {
        
        let urlString: String = baseUrl+AppData.shows+String(seriesID)+AppData.episodes
        Alamofire.request(urlString, method: .get, parameters: nil
            , encoding: URLEncoding.default, headers: nil).responseArray(keyPath: "") { (response: DataResponse<[Episode]>) in
                
                if let result = response.result.value {
                    callback(Result(error: nil, data: result))
                } else {
                    callback(Result(error: nil, data: nil))
                }
        }
        
    }
    
    func getCasts( seriesID: Int, callback:   @escaping ( _ result: Result) -> Void) {
        
        let urlString: String = baseUrl+AppData.shows+String(seriesID)+AppData.cast
        Alamofire.request(urlString, method: .get, parameters: nil
            , encoding: URLEncoding.default, headers: nil).responseArray (keyPath :"") { (response: DataResponse<[Cast]>) in
                
                if let result = response.result.value {
                    callback(Result(error: nil, data: result))
                } else {
                    callback(Result(error: nil, data: nil))
                }
        }
        
    }
    
    func getCrewList(showID:Int, callback:   @escaping ( _ result: Result) -> Void) {
        
        let urlString : String = baseUrl+AppData.shows+String(showID)+AppData.crew
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseArray(keyPath : "") { (response: DataResponse<[Crew]>) in
            
            if let result = response.result.value {
                callback(Result(error: nil, data: result))
            } else {
                callback(Result(error: nil, data: nil))
            }
        }
    }
}
