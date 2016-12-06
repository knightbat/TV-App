//
//  ListViewController.swift
//  TV App
//
//  Created by JK on 06/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var token: String!
    var listArray: NSArray = []
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.isNavigationBarHidden = true
        
        let params: Parameters = [
            "name" : "arrow"
        ]
        
        
        ApiMapper.sharedInstance.getSeries(params: params,
                                           Success: {(dataDict) -> Void in
                                            
                                            self.listArray = dataDict.object(forKey: "data") as! NSArray
                                            self.tableView.reloadData()
        },
                                           Faliure: {(faliure) -> Void in
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  series : NSDictionary = listArray[indexPath.row] as! NSDictionary
        let cell : SeriesTableViewCell = tableView.dequeueReusableCell (withIdentifier: "cell") as! SeriesTableViewCell
        cell.title.text = series.object(forKey: "seriesName") as! String?
        let imagePath : String = "\(ApiMapper.sharedInstance.imageUrl)\(series.object(forKey: "banner") as! String)"
        cell.bannerImageView?.sd_setImage(with: NSURL(string: imagePath ) as URL!, placeholderImage: nil)
        return cell
    }
}