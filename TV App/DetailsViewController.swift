//
//  DetailsViewController.swift
//  TV App
//
//  Created by JK on 12/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var seriesDetails: Series!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        ApiMapper.sharedInstance.getEpisodesDetailsWith(epID: seriesDetails.seriesId!, Success: {(dataDict) -> Void in
        
        }, Faliure: {(errorInfo) -> Void in
        
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
