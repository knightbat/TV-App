//
//  DetailsViewController.swift
//  TV App
//
//  Created by JK on 12/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//

import UIKit


class DetailsViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet var officialSitebutton: UIButton!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var urlButton: UIButton!
    @IBOutlet var runtimeLabel: UILabel!
    @IBOutlet var premieredDateLAbel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var seasonsCollectionView: UICollectionView!
    @IBOutlet var actorsLabel: UILabel!
    @IBOutlet var actorsTableView: UITableView!
    @IBOutlet var seriesImage: UIImageView!
    @IBOutlet var seriesNameLabel: UILabel!
    @IBOutlet var bgImageView: UIImageView!
    @IBOutlet var activity: UIActivityIndicatorView!
    @IBOutlet var summaryLabel: UILabel!
    
    @IBOutlet var tableViewHeight: NSLayoutConstraint!
    var series: Series!
    var seasonsArray: [Season] = []
    var actorsArray: [Actor] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        let imagePath : String = self.series.image ?? AppData.placeholderUrl
        self.seriesImage?.sd_setImage(with: NSURL(string:imagePath  ) as URL!, placeholderImage: nil)
        self.bgImageView?.sd_setImage(with: NSURL(string: imagePath ) as URL!, placeholderImage: nil)
        self.seriesNameLabel.text = self.series.name!
        
        let myAttribute = [ NSFontAttributeName: UIFont(name: "ChalkboardSE-Regular", size:16.0)! ,NSForegroundColorAttributeName:UIColor.white]
        
        do {
            let attrString = try NSMutableAttributedString(data: ((self.series.summary ?? "")?.data(using: String.Encoding.unicode,allowLossyConversion: true))!, options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            attrString.addAttributes(myAttribute, range: NSMakeRange(0, attrString.length))
            summaryLabel.attributedText = attrString
        } catch let error {
            print(error)
            summaryLabel.text = self.series.summary
        }
        
        statusLabel.text = ": "+self.series.status!
        premieredDateLAbel.text = ": "+self.series.premiered!
        runtimeLabel.text = ": \(self.series.runtime ?? 0) min"
        officialSitebutton.setTitle(": "+self.series.officialSite!, for: UIControlState.normal)
        urlButton.setTitle(": "+self.series.seriesURL!, for: UIControlState.normal)
        ratingLabel.text = ": \(self.series.rating ?? 0)"
        
        activity.startAnimating()
        self.view.bringSubview(toFront: activity)
        
        ApiMapper.sharedInstance.getSeasons(seriesID: self.series.seriesID!, Success: { (dataDict) in
            self.seasonsArray = dataDict.value(forKey: "data") as! [Season]
            self.seasonsCollectionView.reloadData()
            self.activity.stopAnimating()
        }, Faliure: {(errorDict) in
            self.activity.stopAnimating()
        })
        
        activity.startAnimating()
        self.view.bringSubview(toFront: activity)
        
        ApiMapper.sharedInstance.getActors(seriesID: series.seriesID!, Success: {(data) -> Void in
            
            self.actorsArray = data.value(forKey: "data") as! [Actor]
            
            if (self.actorsArray.count==0) {
                self.actorsLabel.isHidden=true
            } else {
                self.actorsLabel.isHidden=false
                
            }
            self.actorsTableView.reloadData()
            self.tableViewHeight.constant = self.actorsTableView.contentSize.height
            self.activity.stopAnimating()
        }, Faliure: {(error) -> Void in
            self.activity.stopAnimating()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UICollectionViewDelegate and UICollectionViewDataSource
    
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
        
        cell.actorImageView.sd_setImage(with: NSURL (string:actor.actor!.image ?? AppData.placeholderUrl) as URL!, placeholderImage: nil)
        cell.actorNameLabel.text=String (format :"Name: %@",(actor.actor?.name!)!)
        cell.actorRoleLabel.text=String (format :"Role: %@",(actor.character?.name)!)
        cell.roleImageView.sd_setImage(with: NSURL (string:actor.character!.image ?? AppData.placeholderUrl) as URL!, placeholderImage: nil)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == self.actorsArray.count - 1{
            self.tableViewHeight.constant = tableView.contentSize.height
        }
    }
    // MARK: - Other Methods
    
    @IBAction func officialSiteBtnClicked(_ sender: UIButton) {
    }
    @IBAction func urlBtnClicked(_ sender: UIButton) {
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
