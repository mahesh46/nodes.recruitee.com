//
//  TableViewController.swift
//  MVVM_SWIFT
//
//  Created by Administrator on 07/10/2017.
//  Copyright © 2017 mahesh lad. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchResultsUpdating {
    
    @IBOutlet var  viewModelSearch : SearchViewModel!
 
    let searchController = UISearchController(searchResultsController: nil)
   //image cache
 //   var imageCache = [NSURL : UIImage]()
    let  imageCache = NSCache<AnyObject, AnyObject>()
  
  
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text!)
        //  print("searchbar text")
        viewModelSearch.apps = []
        self.tableView.reloadData()
        var title = searchController.searchBar.text!
        // to put %20 where you have space between words
        let updatedUrl = title.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        viewModelSearch.getApps(title: updatedUrl!) {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "Enter Movie Title"
        self.tableView.tableHeaderView = searchController.searchBar
        
        let nib = UINib(nibName: "ResultTableViewCell", bundle: nil);
        tableView.register(nib, forCellReuseIdentifier: "ResultTableViewCell")
        
        //memory cache https://www.youtube.com/watch?v=BIgqHLTZ_a4
//        let memoryCapacity = 500 * 1024 * 1024
//        let diskCapacity = 500 * 1024 * 1024
//        let urlChache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "mydiskpath")
//        URLCache.setSharedURLCache(urlChache)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
           // imageCache = nil
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelSearch.numberOfItemsToDisplay(in : section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //  let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell") as! ResultTableViewCell
        
        cell.resultIdCell.text = "\(viewModelSearch.appId(for: indexPath))"
        cell.tag =  viewModelSearch.appId(for: indexPath)
        cell.resultTitleCell.text =  viewModelSearch.appTitleToDisplay(for: indexPath)
        cell.resultDescriptionCell.text = viewModelSearch.appDescriptionToDisplay(for: indexPath)
        
       
  
        let globalQueue = DispatchQueue.global()
       globalQueue.async {
        guard  let imageURL = self.viewModelSearch.appPhotoURL( for: indexPath)  else { return  }
       var checkImage = UIImage()
    //    if let image =    imageCache[imageURL] {
        if let image =    self.imageCache.object(forKey: imageURL)  as? UIImage {
            cell.resultCellImage.image = image
            checkImage = image
        } else {
            guard let   imageData = NSData(contentsOf: imageURL as URL) else { return  }
       
            if let image = UIImage(data: imageData as Data) {
        
             //  imageCache[imageURL] = image
                self.imageCache.setObject(image, forKey: imageURL)
                
              checkImage = image
           }
        }
            DispatchQueue.main.async  {
                cell.resultCellImage.image = checkImage
                cell.setNeedsLayout()
                let datamanager = DataManager.sharedInstance
                if   datamanager.isLiked(id: cell.tag) {
                    cell.resultLikeButton.backgroundColor = UIColor.blue
                } else {
                    cell.resultLikeButton.backgroundColor = UIColor.gray
                }
                
            }
       }
        
        return cell
    }
    
    @IBAction func LikesButtonAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let likeslViewController = storyBoard.instantiateViewController(withIdentifier: "LikesViewController") as! LikesTableViewController
        self.navigationController?.pushViewController(likeslViewController, animated: true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchController.searchBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchController.searchBar.isHidden = false
    }
    
 
}
