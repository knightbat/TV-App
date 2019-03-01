
//
//  ApiMapper.swift
//  TV App
//
//  Created by JK on 07/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//
import UIKit

class ApiMapper {
    
    //MARK: Shared Instance
    
    static let sharedInstance : ApiMapper = {
        let instance = ApiMapper()
        return instance
    }()
    
    
    init() {
    }
    
    //MARK: Api Calls

    func getAllSeries(withParams params: [(String, String)], callback: @escaping ( _ result: Result) -> Void){
        
        let url = self.generateURL(withPath: AppData.show, andParams: params)
        self.callAPI(withURL: url, andMappingModel: [Series].self) { (result) in
            callback(result)
        }
    }
    
    func searchSeries(params: [(String, String)], callback: @escaping ( _ result: Result) -> Void){
        
        let url = self.generateURL(withPath: AppData.search, andParams: params)
        self.callAPI(withURL: url, andMappingModel: [SearchResult].self) { (result) in
            callback(result)
        }
    }
    
    
    func getSeasons(seriesID: Int, callback:   @escaping ( _ result: Result) -> Void) {
        let url = self.generateURL(withPath: AppData.shows+String(seriesID)+AppData.season, andParams: [])
        self.callAPI(withURL: url, andMappingModel: [Season].self) { (result) in
            callback(result)
        }
    }
    
    func getEpisodeswith(seriesID: Int, seasonNumber: Int, callback:   @escaping ( _ result: Result) -> Void) {
        
        let pathString = AppData.shows+String(seriesID)+AppData.episodes
        let url = self.generateURL(withPath: pathString , andParams: [])
        self.callAPI(withURL: url, andMappingModel: [Episode].self) { (result) in
            callback(result)
        }
    }
    
    func getCasts( seriesID: Int, callback:   @escaping ( _ result: Result) -> Void) {
        
        let pathString: String = AppData.shows+String(seriesID)+AppData.cast
        let url = self.generateURL(withPath: pathString , andParams: [])
        self.callAPI(withURL: url, andMappingModel: [Cast].self) { (result) in
            callback(result)
        }
    }
    
    func getCrewList(showID:Int, callback:   @escaping ( _ result: Result) -> Void) {
        
        let pathString: String = AppData.shows+String(showID)+AppData.crew
        let url = self.generateURL(withPath: pathString , andParams: [])
        self.callAPI(withURL: url, andMappingModel: [Crew].self) { (result) in
            callback(result)
        }
    }
    
    //MARK: helper methods
    
    func generateURL(withPath path: String, andParams params: [(String, String)]) -> URL {
        
        var urlComp = URLComponents(string: AppData.baseUrl)!
        for param in params {
            urlComp.queryItems?.append(URLQueryItem(name: param.0, value: param.1))
        }
        var url = urlComp.url!
        url = url.appendingPathComponent(path)
        return url
    }
    
    func callAPI<T: Codable>(withURL url: URL, andMappingModel model: T.Type, callback: @escaping (_ result: Result) -> Void ) {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(model, from: data!)
                callback(Result(error: "", data: responseModel))
            } catch {
                callback(Result(error: "Error: unable to serialize data", data: nil))
            }
        }
        task.resume()
    }
}
