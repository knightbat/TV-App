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

class ListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    
    var token: String!
    var listArray: NSArray = []
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let params: Parameters = [
            "page" : "1"
        ]
        
        ApiMapper.sharedInstance.getAllSeries(params: params, Success: {(dataDict) -> Void in
            
            self.listArray = dataDict.object(forKey: "data") as! NSArray
            self.collectionView.reloadData()
            self.view.endEditing(true)
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
    
    func getSeries(obj: Any) -> Series {
        
        let series: Series!
        
        if obj is SearchResult {
            series = (obj as! SearchResult).series!
        } else {
            series = obj as! Series
        }
        
        return series
    }
    
    // MARK: - UICollectionView Delegates and Datasource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let series: Series = getSeries(obj: listArray[indexPath.row])
        let cell : ListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "list", for: indexPath) as! ListCollectionViewCell
        
        cell.bannerImageView?.sd_setImage(with: NSURL(string: series.image ?? "" ) as URL!, placeholderImage: nil)
        cell.seriesNameLabel.text = series.name
        return cell;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (UIScreen.main.bounds.size.width-30)/2, height: UIScreen.main.bounds.size.width/2+50)
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.view.endEditing(true)
        let params: Parameters = [
            "q" : searchBar.text!
        ]
        
        ApiMapper.sharedInstance.searchSeries(params: params, Success: {(dataDict) -> Void in
            
            self.listArray = dataDict.object(forKey: "data") as! NSArray
            self.collectionView.reloadData()
            
        }, Faliure: {(faliure) -> Void in
            
        })
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (searchText.isEmpty) {
            
            let params: Parameters = [
                "page" : "1"
            ]
            
            ApiMapper.sharedInstance.getAllSeries(params: params, Success: {(dataDict) -> Void in
                
                self.listArray = dataDict.object(forKey: "data") as! NSArray
                self.collectionView.reloadData()
                self.view.endEditing(true)
            }, Faliure: {(faliure) -> Void in
                
            })
            
        }
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "details" {
            
            let detailsVC: DetailsViewController = segue.destination as! DetailsViewController
            let cell = sender as! UICollectionViewCell
            let selected: Int = ((self.collectionView.indexPath(for: cell))?.row)!
            detailsVC.series =  getSeries(obj: listArray[selected])
            
        }
    }
    
    
}
