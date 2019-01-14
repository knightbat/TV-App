
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
    
    func getAllSeries(withParams params: [(String, String)], callback: @escaping ( _ result: Result) -> Void){
        
        let url = self.generateURL(withPath: AppData.show, andParams: params)
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try jsonDecoder.decode([SeriesCodable].self, from: data!)
                    callback(Result(error: nil, data: responseModel))
                } catch {
                    print("Error: unable to serialize data")
                    callback(Result(error: nil, data: nil))
                }
        }
        task.resume()
    }
    
    func searchSeries(params: [(String, String)], callback: @escaping ( _ result: Result) -> Void){
        
        let url = self.generateURL(withPath: AppData.search, andParams: params)

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode([SearchResultCodable].self, from: data!)
                callback(Result(error: nil, data: responseModel))
            } catch {
                print("Error: unable to serialize data")
                callback(Result(error: nil, data: nil))
            }
        }
        task.resume()
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
    
    func generateURL(withPath path: String, andParams params: [(String, String)]) -> URL {
        
        var urlComp = URLComponents(string: baseUrl)!
        for param in params {
            urlComp.queryItems?.append(URLQueryItem(name: param.0, value: param.1))
        }
        var url = urlComp.url!
        url = url.appendingPathComponent(path)
        return url
    }
}
