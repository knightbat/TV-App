//
//  DetailsViewController.swift
//  TV App
//
//  Created by JK on 12/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//

import UIKit

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height:.greatestFiniteMagnitude )
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height+10
    }
}
class DetailsViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource {
    
    var seriesDetails: Series!
    var sortedSeasons: [String] = []
    var actorsArray: [Actor] = []
    @IBOutlet var seasonsCollectionView: UICollectionView!
    
    @IBOutlet var actorsLabel: UILabel!
    @IBOutlet var actorsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        ApiMapper.sharedInstance.getEpisodesDetailsWith(epID: seriesDetails.seriesId!, Success: {(dataDict) -> Void in
            
            let seriesInfo: SeriesInfo = dataDict.value(forKey: "data") as! SeriesInfo
            self.sortedSeasons =  (seriesInfo.airedSeasons?.sorted())!
            self.seasonsCollectionView.reloadData()
            
        }, Faliure: {(errorInfo) -> Void in
            
        })
        // Do any additional setup after loading the view.
        
        ApiMapper.sharedInstance.getActors(seriesID: seriesDetails.seriesId!, Success: {(data) -> Void in
            
            self.actorsArray = data.value(forKey: "data") as! [Actor]
            print(self.actorsArray)
            if (self.actorsArray.count==0) {
                self.actorsLabel.isHidden=true
            } else {
                self.actorsLabel.isHidden=false

            }
            self.actorsTableView.reloadData()
            
        }, Faliure: {(error) -> Void in
            
        })
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.sortedSeasons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: SeasonsCollectionViewCell = collectionView .dequeueReusableCell(withReuseIdentifier: "collCell", for: indexPath) as! SeasonsCollectionViewCell
        
        cell.seasonLabel.text = self.sortedSeasons[indexPath.row]
        return cell
    }
    
    // MARK: - Navigation UITableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.actorsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ActorsTableViewCell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ActorsTableViewCell
        
        let actor=self.actorsArray[indexPath.row]
        
        let imagePath : String = "\(ApiMapper.sharedInstance.imageUrl)\(actor.image!)"
        
        cell.actorImageView.sd_setImage(with: NSURL (string:imagePath) as URL!, placeholderImage: nil)
        cell.actorNameLabel.text=String (format :"Name: %@",actor.name!)

        cell.actorRoleLabel.text=String (format :"Role: %@",actor.role!)
        
        cell.layer.borderColor=UIColor.gray.cgColor
        cell.layer.borderWidth=1.5
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let actor=self.actorsArray[indexPath.row]
        
        let nameHeight = actor.name?.heightWithConstrainedWidth(width:tableView.frame.size.width-80 , font: UIFont (name: "Arial", size: 14)!)
        
        let roleHeight = actor.role?.heightWithConstrainedWidth(width:tableView.frame.size.width-80 , font: UIFont (name: "Arial", size: 14)!)
        let height = nameHeight!+roleHeight!
        
        if (height<70) {
            return 70
        } else {
            return height
        }
    }
}
