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
import CCBottomRefreshControl

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {
    
    var token: String!
    var listArray: [Any] = []
    var pageNumber = 1
    let refreshController: UIRefreshControl = UIRefreshControl()
    let bottomRefreshController: UIRefreshControl = UIRefreshControl()

    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPullToRefresh()
        callApi()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Setup Methods

    func setupPullToRefresh()  {
        
        refreshController.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        refreshController.attributedTitle =  NSAttributedString(string: "Pull to refresh")
        tableView.addSubview(refreshController)
        
        bottomRefreshController.addTarget(self, action: #selector(refreshBottom(sender:)), for: .valueChanged)
        bottomRefreshController.triggerVerticalOffset = 100
        tableView.bottomRefreshControl = bottomRefreshController
        
    }
    
    
    func refresh(sender: UIRefreshControl) {
        
        pageNumber = 1
        self.listArray.removeAll()
        if (searchBar.text == "") {
            callApi()
        } else {
            callSearchApi()
        }
        
    }
    
    func refreshBottom(sender: UIRefreshControl) {
        pageNumber += 1
        if (searchBar.text == "") {
            callApi()
        } else {
            bottomRefreshController.endRefreshing()
        }
    }
    
    func callApi() {
        
        let params: Parameters = [
            "page" : pageNumber
        ]
        
        ApiMapper.sharedInstance.getAllSeries(params: params, Success: {(dataDict) -> Void in
            
            let resultArray = dataDict.object(forKey: "data") as! [Any];
            if(resultArray.count > 0) {
                self.listArray.append(contentsOf: resultArray)
                self.tableView.reloadData()
                self.view.endEditing(true)
            }
            self.refreshController.endRefreshing()
            self.bottomRefreshController.endRefreshing()
            
        }, Faliure: {(faliure) -> Void in
            
            self.pageNumber -= 1
            if self.pageNumber <= 0 {
                self.pageNumber = 1;
            }
            self.refreshController.endRefreshing()
            self.bottomRefreshController.endRefreshing()
        })
    }
    
    func callSearchApi()  {
        
        self.view.endEditing(true)
        let params: Parameters = [
            "q" : searchBar.text!
        ]
        
        ApiMapper.sharedInstance.searchSeries(params: params, Success: {(dataDict) -> Void in
            
            self.listArray = dataDict.object(forKey: "data") as! [Any]
            self.tableView.reloadData()
            self.refreshController.endRefreshing()
            self.bottomRefreshController.endRefreshing()
        }, Faliure: {(faliure) -> Void in
            self.refreshController.endRefreshing()
            self.bottomRefreshController.endRefreshing()
        })
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
    
    // MARK: - UITableViewDelegate

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let series: Series = getSeries(obj: listArray[indexPath.row])
        
        let cell : SeriesTableViewCell = tableView.dequeueReusableCell (withIdentifier: "cell") as! SeriesTableViewCell
        cell.title.text = series.name
        
        
        cell.bannerImageView?.sd_setImage(with: NSURL(string: series.image ?? AppData.placeholderUrl ) as URL!, placeholderImage: nil)
        return cell
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
       callSearchApi()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (searchText.isEmpty) {
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
            let selected: Int = (self.tableView.indexPathForSelectedRow?.row)!
            detailsVC.series =  getSeries(obj: listArray[selected])

        }
    }
    
    
}
