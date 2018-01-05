//
//  CastNCrewCollectionViewCell.swift
//  TV App
//
//  Created by Bindu on 05/01/18.
//  Copyright © 2018 xminds. All rights reserved.
//

import UIKit

class CastNCrewCollectionViewCell: UICollectionViewCell,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var castNCrewTableView: UITableView!
    
    var isCastClicked : Bool = Bool()
    var  castArray :[Cast] = []
    
    // MARK: - TableViewDatasource and delegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isCastClicked {
            return castArray.count
        } else {
            return 2;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //        if isCastClicked {
        let cell: ActorsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "aCell") as! ActorsTableViewCell
        
        let cast: Cast=self.castArray[indexPath.row]
        cell.actorImageView.sd_setImage(with: NSURL (string:cast.actor!.image ?? AppData.placeholderUrl) as URL!, placeholderImage: nil)
        cell.actorNameLabel.text=String (format :"Name: %@",(cast.actor?.name!)!)
        cell.actorRoleLabel.text=String (format :"Role: %@",(cast.character?.name)!)
        cell.roleImageView.sd_setImage(with: NSURL (string:cast.character!.image ?? AppData.placeholderUrl) as URL!, placeholderImage: nil)
        
        return cell
        //        } else {
        //
        //        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
        
    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row == self.castArray.count - 1{
//            self.tableViewHeight.constant = tableView.contentSize.height        }
//    }
}
