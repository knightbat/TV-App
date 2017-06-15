//
//  DetailsViewController.swift
//  TV App
//
//  Created by JK on 12/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//

import UIKit


class DetailsViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet var seasonsCollectionView: UICollectionView!
    @IBOutlet var actorsLabel: UILabel!
    @IBOutlet var actorsTableView: UITableView!
    @IBOutlet var seriesImage: UIImageView!
    @IBOutlet var seriesNameLabel: UILabel!
    @IBOutlet var bgImageView: UIImageView!
    
    var series: Show!
    var seasonsArray: [Season] = []
    var actorsArray: [Actor] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        let imagePath : String = self.series.image!
        self.seriesImage?.sd_setImage(with: NSURL(string:imagePath  ) as URL!, placeholderImage: nil)
        self.bgImageView?.sd_setImage(with: NSURL(string: imagePath ) as URL!, placeholderImage: nil)
        self.seriesNameLabel.text = self.series.name!
        
        ApiMapper.sharedInstance.getSeasons(seriesID: self.series.seriesID!, Success: { (dataDict) in
            self.seasonsArray = dataDict.value(forKey: "data") as! [Season]
            self.seasonsCollectionView.reloadData()
        }, Faliure: {(errorDict) in
        })
        
        
        ApiMapper.sharedInstance.getActors(seriesID: series.seriesID!, Success: {(data) -> Void in
            
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
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.seasonsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: SeasonsCollectionViewCell = collectionView .dequeueReusableCell(withReuseIdentifier: "collCell", for: indexPath) as! SeasonsCollectionViewCell
        
        let season : Season = self.seasonsArray[indexPath.row]
        cell.seasonLabel.text = "\(season.number ?? 0)"
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
        
        let actor: Actor=self.actorsArray[indexPath.row]
        let imagePath : String = (actor.actor?.image)!
        
        cell.actorImageView.sd_setImage(with: NSURL (string:imagePath) as URL!, placeholderImage: nil)
        cell.actorNameLabel.text=String (format :"Name: %@",(actor.actor?.name!)!)
        
        cell.actorRoleLabel.text=String (format :"Role: %@",(actor.character?.name)!)
        
        cell.layer.borderColor=UIColor.gray.cgColor
        cell.layer.borderWidth=1.5
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "episodes" {
            
            let episodesVC: EpisodesViewController = segue.destination as! EpisodesViewController
            
            let index: Int = (self.seasonsCollectionView.indexPathsForSelectedItems?[0].row)!
            
            let selectedSeason : Season =  seasonsArray[index]
            episodesVC.seasonIndex = index
            episodesVC.seriesID =  series.seriesID
            if (selectedSeason.image != nil) {
                episodesVC.imageUrl = selectedSeason.image
            } else {
                episodesVC.imageUrl = series.image
            }
            episodesVC.seasonArray = seasonsArray
        }
    }
    
}
