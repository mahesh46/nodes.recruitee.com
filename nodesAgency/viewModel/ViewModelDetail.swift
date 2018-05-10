//
//  DetailViewModel.swift
//  nodesAgency
//
//  Created by Administrator on 04/05/2018.
//  Copyright © 2018 mahesh lad. All rights reserved.
//

import Foundation
class DetailViewModel: NSObject {
    @IBOutlet var apiClient : ApiClient!
    var apps :  NSDictionary?
    
//    func getAppDetal( completion: @escaping () -> Void) {
//        apiClient.fetchApDetail{   (arrayOfAppsDictionaries) in
//            
//            DispatchQueue.main.async {
//                self.apps = arrayOfAppsDictionaries
//                
//                completion()
//            }
//        }
//        
//    }
    func getAppDetals( id: Int, completion: @escaping () -> Void) {
        apiClient.fetchApDetails(id: id){   (arrayOfAppsDictionaries) in
            
            DispatchQueue.main.async {
                self.apps = arrayOfAppsDictionaries
                completion()
            }
        }
        
    }
    
    func numberOfItemsToDisplay(in section: Int) -> Int{
        return apps?.count ?? 0
    }
    
    func getDetailName( ) -> String {
        return   apps?.value(forKeyPath: "overview") as? String  ??  ""
    }
    
    //backdrop_path
    
    func   appPhotoURL( for indexPath: IndexPath) ->  NSURL? {
        
        let urlImage =  "https://image.tmdb.org/t/p/w250_and_h141_face/"
            +  (apps?.value(forKeyPath: "backdrop_path") as? String  ?? "")
        return NSURL(string: urlImage)
    }
    
    func getTitleDesc()-> String {
        return  apps?.value(forKeyPath: "title") as? String  ??  ""
    }
    
    func getRating( ) -> Double {
        return  apps?.value(forKeyPath: "vote_average") as? Double ??  0.0
    }
    
    
}
