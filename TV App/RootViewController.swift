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
        
        ApiMapper.sharedInstance.getToken( params: params, Success: {(dataDict) -> Void in
            
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
    
}
