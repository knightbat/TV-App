//
//  DetailsViewController.swift
//  TV App
//
//  Created by JK on 12/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {

    var seriesDetails: Series!
    var sortedSeasons: [String] = []
    @IBOutlet var seasonsCollectionView: UICollectionView!
    
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
}
