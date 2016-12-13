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

        let params: Parameters = [
            "name" : "arrow"
        ]
        
        
        ApiMapper.sharedInstance.getSeries(params: params, Success: {(dataDict) -> Void in
            
            self.listArray = dataDict.object(forKey: "data") as! NSArray
            self.tableView.reloadData()
            
        }, Faliure: {(faliure) -> Void in
            
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  series : Series = listArray[indexPath.row] as! Series
        let cell : SeriesTableViewCell = tableView.dequeueReusableCell (withIdentifier: "cell") as! SeriesTableViewCell
        cell.title.text = series.seriesName
        let imagePath : String = "\(ApiMapper.sharedInstance.imageUrl)\(series.banner!)"
        cell.bannerImageView?.sd_setImage(with: NSURL(string: imagePath ) as URL!, placeholderImage: nil)
        return cell
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "details" {
            
            let detailsVC: DetailsViewController = segue.destination as! DetailsViewController
            let selected: Int = (self.tableView.indexPathForSelectedRow?.row)!
            detailsVC.seriesDetails = listArray[selected] as! Series
            
        }
    }
    
    
}
