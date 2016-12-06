//
//  RootViewController.swift
//  TV App
//
//  Created by JK on 06/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//

import UIKit
import Alamofire

class RootViewController: UIViewController {

    var token: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let params = [
                "apikey": "C57F534F60E672E4",
                "username": "knightbat",
                "userkey": "BC57E64B5DBF4A2A"
        ]
        

//            let content : [String:String] = data.content as! [String : String]
//            self.token = content["token"]
//            self.performSegue(withIdentifier: "list", sender: nil)
        

        
//        Alamofire.request("https://api.thetvdb.com/login", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
//            
//            if let result = response.result.value {
//                let json = result as! NSDictionary
//                self.token = json.value(forKey: "token") as! String?
//                self.performSegue(withIdentifier: "list", sender: nil)
//            }
//        }

        ApiMapper.sharedInstance.getToken( params: params,
            Success: {(dataDict) -> Void in
            
            print(dataDict)
                        self.performSegue(withIdentifier: "list", sender: nil)
        },Faliure: {(error) -> Void in
            print(error)
            
        })
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

//    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
//        
//        let json = resource.jsonDict
//        print(json);
//    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}
