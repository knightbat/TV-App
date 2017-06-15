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
        
        
            self.performSegue(withIdentifier: "list", sender: nil)
            

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
