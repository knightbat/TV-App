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

class ListViewController: UIViewController {
    
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
    }
    
    // MARK: - Setup Methods
    
    func setupPullToRefresh()  {
        
        refreshController.addTarget(self, action: #selector(ListViewController.refresh(sender:)), for: .valueChanged)
        refreshController.attributedTitle =  NSAttributedString(string: "")
        refreshController.tintColor = UIColor.white
        collectionView.addSubview(refreshController)
        
        bottomRefreshController.addTarget(self, action: #selector(ListViewController.refreshBottom(sender:)), for: .valueChanged)
        bottomRefreshController.triggerVerticalOffset = 100
        collectionView.bottomRefreshControl = bottomRefreshController
        
    }
    
    // MARK: - IBActions
    
    @IBAction func refresh(sender: UIRefreshControl) {
        
        pageNumber = 1
        self.listArray.removeAll()
        if (searchBar.text == "") {
            callApi()
        } else {
            callSearchApi()
        }
        
    }
    
    @IBAction func refreshBottom(sender: UIRefreshControl) {
        pageNumber += 1
        if (searchBar.text == "") {
            callApi()
        } else {
            bottomRefreshController.endRefreshing()
        }
    }
    
    
    func getSeries(fromObject obj: Any?) -> Result<Series, Error> {
        
        if let seriesRes : SearchResult =  obj as? SearchResult, let series = seriesRes.series {
            return Result.success(series)
        } else if let series : Series = obj as? Series  {
            return Result.success(series)
        } else {
            return Result.failure(AppError.invalidFormat)
        }
    }
    
    // MARK: - Call Api
    
    
    func callApi() {
        
        activity.startAnimating()
        let params = [
            ("page", String(pageNumber))
        ]
        ApiMapper.sharedInstance.callAPI(withPath: AppData.show, params: params, andMappingModel: [Series].self) { (result) in
            
            DispatchQueue.main.async {
                
                switch(result) {
                case .success(let resultArray):
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
                    
                    
                case .failure(_):
                    self.pageNumber -= 1
                    if self.pageNumber <= 0 {
                        self.pageNumber = 1;
                    }
                    self.refreshController.endRefreshing()
                    self.bottomRefreshController.endRefreshing()
                    self.activity.stopAnimating()
                }
            }
        }
    }
    
    func callSearchApi()  {
        activity.startAnimating()
        self.view.endEditing(true)
        let params = [
            ("q", searchBar.text!)
        ]        
        ApiMapper.sharedInstance.callAPI(withPath: AppData.search, params: params, andMappingModel: [SearchResult].self) { (result) in
            
            DispatchQueue.main.async {
                
                switch(result) {
                case .success(let resultArray):
                    self.listArray = resultArray
                    self.collectionView.reloadData()
                    self.refreshController.endRefreshing()
                    self.bottomRefreshController.endRefreshing()
                    if self.isScrollToTop {
                        self.isScrollToTop = false
                        self.collectionView?.setContentOffset(CGPoint.zero, animated: true)
                    }
                    self.activity.stopAnimating()
                    
                case .failure(_):
                    self.refreshController.endRefreshing()
                    self.bottomRefreshController.endRefreshing()
                    self.activity.stopAnimating()
                }
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "details" {
            let detailsVC = segue.destination as? DetailsViewController
            detailsVC?.modalPresentationStyle = .fullScreen
            if let cell = sender as? UICollectionViewCell, let selected = self.collectionView.indexPath(for: cell)?.row {
                switch(getSeries(fromObject: listArray[selected])) {
                case .success(let series) :
                    detailsVC?.series = series
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "list", for: indexPath) as! ListCollectionViewCell
        switch(getSeries(fromObject: listArray[indexPath.row])) {
        case .success(let series) :
            cell.setupWith(series: series)
        case .failure(let error):
            print(error.localizedDescription)
        }
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = UIScreen.main.bounds.size.width > UIScreen.main.bounds.size.height ?  UIScreen.main.bounds.size.height : UIScreen.main.bounds.size.width
        
        return CGSize.init(width: (size - 30)/2, height: size/2+50)
    }
}

extension ListViewController: UISearchBarDelegate {
    
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
}
