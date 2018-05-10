//
//  LikesTableViewController.swift
//  nodesAgency
//
//  Created by Administrator on 05/05/2018.
//  Copyright © 2018 mahesh lad. All rights reserved.
//

import UIKit

class LikesTableViewController: UITableViewController {
    
    var likes = [Likes]()
    
    @IBOutlet var  viewModelDetail : DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let likeModel =    LikesViewModel()
        let globalQueue = DispatchQueue.global()
        globalQueue.async {
            self.likes = likeModel.getLikes()
        }
        self.title   = "Likes"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return likes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // Configure the cell...
        cell.textLabel?.text  = likes[indexPath.row].title
        cell.textLabel?.font = UIFont(name: "system", size: 14.0)
        cell.imageView?.image = UIImage( data:   likes[indexPath.row].image!)
        cell.imageView?.contentMode = .scaleAspectFit
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // https://api.themoviedb.org/3/movie/<id>?api_key=4cb1eeab94f45affe2536f2c684a5c9e
        
        let id = likes[indexPath.row].id 
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyBoard.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        
        //    self.present(vc, animated: true, completion: nil)
        viewModelDetail.getAppDetals(id: Int(id)) {
            let name    =    self.viewModelDetail.getDetailName()
            let title  =  self.viewModelDetail.getTitleDesc( )
            let rating =  "Rating: \(self.viewModelDetail.getRating())"
            
            detailViewController.detail = Detail(nameText: name, titleText: title, ratingText: rating)
            
            let globalQueue = DispatchQueue.global()
            globalQueue.async {
                guard  let imageURL = self.viewModelDetail.appPhotoURL( for: indexPath) , let   imageData = NSData(contentsOf: imageURL as URL) else {
                    return
                }
                DispatchQueue.main.async  {
                    detailViewController.posterImage.image = UIImage(data: imageData as Data)
                    
                }
            }
            DispatchQueue.main.async  {
                self.navigationController?.pushViewController(detailViewController, animated: true)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let id = likes[indexPath.row].value(forKey: "id") as! Int
            likes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
      
            let datamanager = DataManager.sharedInstance
            datamanager.deleteLike(id: id)
        }
    }
}
