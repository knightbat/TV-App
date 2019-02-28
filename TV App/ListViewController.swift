//
//  ListViewController.swift
//  TV App
//
//  Created by JK on 06/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//

import UIKit
import SDWebImage
import CCBottomRefreshControl

class ListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    
    var listArray: [Any] = []
    var pageNumber = 1
    let refreshController: UIRefreshControl = UIRefreshControl()
    let bottomRefreshController: UIRefreshControl = UIRefreshControl()
    var isScrollToTop = false
    
    
    @IBOutlet var activity: UIActivityIndicatorView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupPullToRefresh()
        callApi()
        
//        try! NSMutableAttributedString(data: "<a>asdasd</a>".data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: [ NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Setup Methods
    
    func setupPullToRefresh()  {
        
        refreshController.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        refreshController.attributedTitle =  NSAttributedString(string: "")
        refreshController.tintColor = UIColor.white
        collectionView.addSubview(refreshController)
        
        bottomRefreshController.addTarget(self, action: #selector(refreshBottom(sender:)), for: .valueChanged)
        bottomRefreshController.triggerVerticalOffset = 100
        collectionView.bottomRefreshControl = bottomRefreshController
        
    }
    
    
    @objc func refresh(sender: UIRefreshControl) {
        
        pageNumber = 1
        self.listArray.removeAll()
        if (searchBar.text == "") {
            callApi()
        } else {
            callSearchApi()
        }
        
    }
    
    @objc func refreshBottom(sender: UIRefreshControl) {
        pageNumber += 1
        if (searchBar.text == "") {
            callApi()
        } else {
            bottomRefreshController.endRefreshing()
        }
    }
    
    
    func getSeries(obj: Any) -> Series {
        
        let series: Series!
        
        if obj is SearchResult {
            series = (obj as! SearchResult).series!
        } else {
            series = obj as? Series
        }
        
        return series
    }
    
    // MARK: - Call Api
    
    
    func callApi() {
        
        activity.startAnimating()
        let params = [
            ("page", String(pageNumber))
            ]
        
        
        ApiMapper.sharedInstance.getAllSeries(withParams: params) { (result) in
            
            guard let resultArray: [Any] = result.data as? [Any] else {
                self.pageNumber -= 1
                if self.pageNumber <= 0 {
                    self.pageNumber = 1;
                }
                self.refreshController.endRefreshing()
                self.bottomRefreshController.endRefreshing()
                self.activity.stopAnimating()
                return
            }
            
            if(resultArray.count > 0) {
                self.listArray.append(contentsOf: resultArray)
                self.collectionView.reloadData()
                self.view.endEditing(true)
            }
            self.refreshController.endRefreshing()
            self.bottomRefreshController.endRefreshing()
            if self.isScrollToTop {
                self.isScrollToTop = false
                self.collectionView?.setContentOffset(CGPoint.zero, animated: true)
            }
            self.activity.stopAnimating()
        }
    }
    
    func callSearchApi()  {
        
        activity.startAnimating()
        
        self.view.endEditing(true)
        let params = [
            ("q", searchBar.text!)
        ]
        
        ApiMapper.sharedInstance.searchSeries(params: params) { (result) in
            
            guard let resultArray: [Any] = result.data as? [Any] else {
                self.refreshController.endRefreshing()
                self.bottomRefreshController.endRefreshing()
                self.activity.stopAnimating()
                return
            }

            self.listArray = resultArray
            self.collectionView.reloadData()
            self.refreshController.endRefreshing()
            self.bottomRefreshController.endRefreshing()
            if self.isScrollToTop {
                self.isScrollToTop = false
                self.collectionView?.setContentOffset(CGPoint.zero, animated: true)
            }
            self.activity.stopAnimating()
        }
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
        
        
        cell.bannerImageView?.sd_setImage(with: URL(string: series.image?.original ?? AppData.placeholderUrl), placeholderImage: nil)
        cell.seriesNameLabel.text = series.name
        cell.ratingLabel.text = "\(series.rating?.average ?? 0)"
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = UIScreen.main.bounds.size.width > UIScreen.main.bounds.size.height ?  UIScreen.main.bounds.size.height : UIScreen.main.bounds.size.width
        
        return CGSize.init(width: (size - 30)/2, height: size/2+50)
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        isScrollToTop = true
        callSearchApi()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.isEmpty) {
            isScrollToTop = true
            pageNumber = 1
            self.listArray.removeAll()
            callApi()
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
