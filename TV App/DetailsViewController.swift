//
//  DetailsViewController.swift
//  TV App
//
//  Created by JK on 12/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    
    @IBOutlet var officialSitebutton: UIButton!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var urlButton: UIButton!
    @IBOutlet var runtimeLabel: UILabel!
    @IBOutlet var premieredDateLAbel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var seasonsCollectionView: UICollectionView!
    @IBOutlet var actorsTableView: UITableView!
    @IBOutlet var seriesImage: UIImageView!
    @IBOutlet var seriesNameLabel: UILabel!
    @IBOutlet var bgImageView: UIImageView!
    @IBOutlet var activity: UIActivityIndicatorView!
    @IBOutlet var summaryLabel: UILabel!
    
    @IBOutlet weak var crewView: UIView!
    @IBOutlet weak var castView: UIView!
    @IBOutlet weak var crewButton: UIButton!
    @IBOutlet weak var castButton: UIButton!
    @IBOutlet var tableViewHeight: NSLayoutConstraint!
    var series: Series!
    var seasonsArray: [Season] = []
    var castsArray: [Cast] = []
    var crewArray : [Crew] = []
    var isCastClicked :Bool = Bool()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setupUI()
        self.callSeasonAPI()
        self.callCastAPI()
        self.callCrewAPI()
    }
    
    // MARK: - Setup methods
    
    func setupUI() {
        
        self.navigationController?.isNavigationBarHidden = false
        isCastClicked = true
        castView.isHidden = false
        crewView.isHidden = true
        crewButton.isHidden = true
        castButton.isHidden = true
        
        let imagePath: String = self.series.image?.original ?? AppData.placeholderUrl
        self.seriesImage?.sd_setImage(with: URL(string:imagePath), placeholderImage: nil)
        self.bgImageView?.sd_setImage(with: URL(string: imagePath), placeholderImage: nil)
        self.seriesNameLabel.text = self.series.name!
        
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "ChalkboardSE-Regular", size:16.0)! ,NSAttributedString.Key.foregroundColor:UIColor.white]
        
        do {
            let attrString = try NSMutableAttributedString(data: ((self.series.summary ?? "")?.data(using: String.Encoding.unicode,allowLossyConversion: true))!, options: [ NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            attrString.addAttributes(myAttribute, range: NSMakeRange(0, attrString.length))
            summaryLabel.attributedText = attrString
        } catch let error {
            print(error)
            summaryLabel.text = self.series.summary
        }
        
        statusLabel.text = self.series.status!
        
        if (self.series.premiered != nil) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = AppData.dateFormatApi
            let date: Date = dateFormatter.date(from: self.series.premiered!)!
            dateFormatter.dateFormat = AppData.dateFormat
            premieredDateLAbel.text = dateFormatter.string(from: date)
        }
        
        runtimeLabel.text = "\(self.series.runtime ?? 0) min"
        
        let url = NSAttributedString(string: self.series.seriesURL ?? "")
        urlButton.setAttributedTitle(url, for: UIControl.State.normal)
        
        let officialSite = NSAttributedString(string: self.series.officialSite ?? "")
        officialSitebutton.setAttributedTitle(officialSite, for: UIControl.State.normal)
        ratingLabel.text = "\(self.series.rating?.average ?? 0)"
    }
    
    // MARK: - API call
    
    func callSeasonAPI() {
        activity.startAnimating()
        self.view.bringSubviewToFront(activity)
        
        let path = "\(AppData.shows)\(self.series.seriesID ?? 0)\(AppData.season)"
        ApiMapper.sharedInstance.callAPI(withPath: path, params: [], andMappingModel: [Season].self) { (result) in
            switch(result) {
            case .success(let resultArray):
                self.seasonsArray = resultArray
                self.seasonsCollectionView.reloadData()
                self.activity.stopAnimating()
            case .failure(_):
                self.activity.stopAnimating()
            }
        }
    }
    
    func callCastAPI() {
        activity.startAnimating()
        self.view.bringSubviewToFront(activity)
        let pathString: String = "\(AppData.shows)\(series.seriesID ?? 0)\(AppData.cast)"
        
        ApiMapper.sharedInstance.callAPI(withPath: pathString, params: [], andMappingModel: [Cast].self) { (result) in
            switch(result) {
            case .success(let resultArray):
                self.castsArray = resultArray
                self.castButton.isHidden = self.castsArray.count == 0
            case .failure(_):
                break
            }
        }
    }
    
    func callCrewAPI() {
        
        let pathString: String = "\(AppData.shows)\(self.series.seriesID ?? 0)\(AppData.crew)"
        
        ApiMapper.sharedInstance.callAPI(withPath: pathString, params: [], andMappingModel: [Crew].self) { (result) in
            
            switch(result) {
            case .success(let resultArray):
                self.crewArray = resultArray
                self.crewButton.isHidden = self.crewArray.count == 0
                self.actorsTableView.reloadData()
                self.tableViewHeight.constant = self.actorsTableView.contentSize.height
                self.activity.stopAnimating()
            case .failure(_):
                self.activity.stopAnimating()
            }
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func crewBtnClicked(_ sender: UIButton) {
        castView.isHidden = true
        crewView.isHidden = false
        
        isCastClicked = false
        
        actorsTableView.reloadData()
    }
    
    @IBAction func castBtnClicked(_ sender: UIButton) {
        castView.isHidden = false
        crewView.isHidden = true
        
        isCastClicked = true
        actorsTableView.reloadData()
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func officialSiteBtnClicked(_ sender: UIButton) {
        
        if let url = URL(string: self.series.officialSite ?? "") {
            if !UIApplication.shared.openURL(url as URL) {
                print("Failed to open url :"+url.description)
            }
        }
    }
    
    @IBAction func urlBtnClicked(_ sender: UIButton) {
        
        if let url = NSURL(string: self.series.seriesURL ?? "") {
            if !UIApplication.shared.openURL(url as URL) {
                print("Failed to open url :"+url.description)
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "episodes" {
            let episodesVC: EpisodesViewController = segue.destination as! EpisodesViewController
            let index: Int = (self.seasonsCollectionView.indexPathsForSelectedItems?[0].row)!
            let selectedSeason : Season =  seasonsArray[index]
            episodesVC.selectedSeason = index
            episodesVC.seriesID =  series.seriesID
            if (selectedSeason.image != nil) {
                episodesVC.imageUrl = selectedSeason.image?.original
            } else if (series.image != nil) {
                episodesVC.imageUrl = series.image?.original
            }
            episodesVC.seriesName = series.name
            episodesVC.seasonArray = seasonsArray
        }
    }
}


extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.seasonsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collCell", for: indexPath) as! SeasonsCollectionViewCell
        
        let season : Season = self.seasonsArray[indexPath.row]
        cell.seasonLabel.text = "\(season.number ?? 0)"
        return cell
    }
}


extension DetailsViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isCastClicked {
            return self.castsArray.count
        } else {
            return self.crewArray.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isCastClicked {
            let cell: CastTableViewCell=tableView.dequeueReusableCell(withIdentifier: "castCell", for: indexPath) as! CastTableViewCell
            let cast: Cast = self.castsArray[indexPath.row]
            cell.setupWithCast(cast: cast)
            return cell
        } else {
            let cell: CrewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "crewCell", for: indexPath) as! CrewTableViewCell
            let crew: Crew = self.crewArray[indexPath.row]
            cell.setupWithCrew(crew: crew)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isCastClicked {
            if indexPath.row == self.castsArray.count - 1{
                self.tableViewHeight.constant = tableView.contentSize.height
            }
        }
    }
}
