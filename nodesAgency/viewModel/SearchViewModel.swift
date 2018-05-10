//
//  SearchViewModel.swift
//  nodesAgency
//
//  Created by Administrator on 20/12/2017.
//  Copyright © 2017 mahesh lad. All rights reserved.
//

import UIKit

class SearchViewModel: NSObject {
    @IBOutlet var apiClient : ApiClient!
    var apps :  [NSDictionary]?
    
    func getApps(title: String, completion: @escaping () -> Void) {
        apiClient.fetchApiList(title: title){   (arrayOfAppsDictionaries) in
            DispatchQueue.main.async {
                self.apps = arrayOfAppsDictionaries
                completion()
            }
        }
    }
    
    func numberOfItemsToDisplay(in section: Int) -> Int{
        return apps?.count ?? 0
    }
    
    
    func appTitleToDisplay( for indexPath: IndexPath) -> String {
        return  apps?[indexPath.row].value(forKeyPath: "title") as? String  ??  ""
    }
    
    
    
    func appDescriptionToDisplay( for indexPath: IndexPath) -> String {
        return  apps?[indexPath.row].value(forKeyPath: "overview") as? String  ??  ""
    }
    //
    func appId( for indexPath: IndexPath) -> Int {
        return  apps?[indexPath.row].value(forKeyPath: "id") as? Int  ??  0
    }
    
    func   appPhotoURL( for indexPath: IndexPath) ->  NSURL? {
        let urlImage =  "https://image.tmdb.org/t/p/w250_and_h141_face/" +  (apps?[indexPath.row].value(forKeyPath: "poster_path") as? String  ?? "")
        return NSURL(string: urlImage)
    }
    
    func getVoteAverage( for indexPath: IndexPath) -> Decimal {
        return  apps?[indexPath.row].value(forKeyPath: "vote_average") as? Decimal  ??  0.0
    }
    
    func getId( for indexPath: IndexPath) -> Int {
        return  apps?[indexPath.row].value(forKeyPath: " id") as? Int  ??  0
    }
    func getVoteCount( for indexPath: IndexPath) -> Int {
        return  apps?[indexPath.row].value(forKeyPath: "vote_count") as? Int  ??  0
    }
    
}
