//
//  EpisodesViewController.swift
//  TV App
//
//  Created by JK on 13/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//
import UIKit

class EpisodesViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var topCollectionView: UICollectionView!
    @IBOutlet var episodeCollectionView: UICollectionView!
    @IBOutlet var seasonLabel: UILabel!
    @IBOutlet var bgImage: UIImageView!
    @IBOutlet var activity: UIActivityIndicatorView!
    @IBOutlet var seriesNameLabel: UILabel!
    
    var seriesID: Int!
    var selectedSeason: Int!
    var episodeArray: [Episode] = []
    var imageUrl: String!
    var seriesName: String!
    var seasonArray: [Season] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let season : Season = self.seasonArray[selectedSeason]
        self.seasonLabel.text =  "Season : \(season.number ?? 0)"
        
        if imageUrl == nil {
            imageUrl = AppData.placeholderUrl
        }
        
        seriesNameLabel.text = seriesName
        self.bgImage?.sd_setImage(with: URL(string: season.image ?? imageUrl), placeholderImage: nil)
        
        activity.startAnimating()
        self.view.bringSubview(toFront: activity)
        
        ApiMapper.sharedInstance.getEpisodeswith(seriesID: seriesID, seasonNumber: selectedSeason) { (result) in
            
            guard let resultArray: [Episode] = result.data as? [Episode] else {
                self.activity.stopAnimating()
                return
            }
            
            self.episodeArray = resultArray
            self.episodeCollectionView.reloadData()
            self.topCollectionView.reloadData()
            let indexPath: NSIndexPath = NSIndexPath.init(item: self.selectedSeason, section: 0)
            self.topCollectionView.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
            self.episodeCollectionView.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
            self.activity.stopAnimating()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        episodeCollectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc:EpisodeDetailsViewController=segue.destination as! EpisodeDetailsViewController
        vc.seriesName = seriesName
        
        let indexPath: NSIndexPath = NSIndexPath.init(item: selectedSeason, section: 0)
        let collViewCell: SeasonEpisodeCollectionViewCell  = episodeCollectionView.cellForItem(at: indexPath as IndexPath) as! SeasonEpisodeCollectionViewCell
        
        let season : Season = self.seasonArray[selectedSeason]
        var selectedSeasonArray: [Episode] = self.episodeArray.filter {$0.airedSeason==season.number};
        
        
        let episode: Episode = selectedSeasonArray[(collViewCell.episodeTableView.indexPathForSelectedRow?.row)!]
        vc.episode = episode
        vc.seriesImage = imageUrl
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - CollectionView Delegates and Datasources
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.seasonArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag==42 {
            
            let season : Season = self.seasonArray[indexPath.row]
            let seasonImageUrl = season.image
            
            if (seasonImageUrl != nil) {
                
                self.bgImage?.sd_setImage(with: URL(string: seasonImageUrl ?? AppData.placeholderUrl), placeholderImage: nil)
            } else {
                self.bgImage?.sd_setImage(with: URL(string: season.image ?? imageUrl), placeholderImage: nil)
            }
            let selectedSeasonArray: [Episode] = self.episodeArray.filter {$0.airedSeason==season.number};
            let cell: SeasonEpisodeCollectionViewCell = collectionView .dequeueReusableCell(withReuseIdentifier: "epSeCell", for: indexPath) as! SeasonEpisodeCollectionViewCell
            cell.selectedSeasonArray = selectedSeasonArray
            cell.episodeTableView.reloadData()
            return cell
            
        } else {
            
            let cell: SeasonsCollectionViewCell = collectionView .dequeueReusableCell(withReuseIdentifier: "season", for: indexPath) as! SeasonsCollectionViewCell
            
            let season : Season = self.seasonArray[indexPath.row]
            cell.seasonLabel.text = "\(season.number ?? 0)"
            if indexPath.row==selectedSeason {
                cell.seasonLabel.backgroundColor = UIColor.brown
            } else {
                cell.seasonLabel.backgroundColor = UIColor.gray
            }
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.tag != 42 {
            
            let season : Season = self.seasonArray[indexPath.row]
            self.seasonLabel.text =  "Season : \(season.number ?? 0)"
            selectedSeason = indexPath.row
            collectionView.reloadData()
            self.episodeCollectionView.reloadData()
            
            collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
            episodeCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == 42 {
            return CGSize.init(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
            
        } else {
            return CGSize.init(width: 50, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView.tag == 42 {
            return 0
        } else {
            return 10;
        }
    }
    
    // MARK: - ScrollView Delegates
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        // used to find current page
        if scrollView.tag == 42 {
            let pageWidth: CGFloat = episodeCollectionView.frame.size.width;
            let currentPage: Float = Float(episodeCollectionView.contentOffset.x / pageWidth);
            let indexPath = NSIndexPath.init(row: Int(currentPage), section: 0)
            topCollectionView.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
            let season : Season = self.seasonArray[indexPath.row]
            self.seasonLabel.text =  "Season : \(season.number ?? 0)"
            selectedSeason = indexPath.row
            topCollectionView.reloadData()
        }
    }
}


