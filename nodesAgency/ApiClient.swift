//
//  ApiClient.swift
//  nodesAgency
//
//  Created by Administrator on 20/12/2017.
//  Copyright © 2017 mahesh lad. All rights reserved.
//  http://microblogging.wingnity.com/JSONParsingTutorial/jsonActors

import UIKit

class ApiClient: NSObject {
    
    
    func fetchApiList(title: String, completion:@escaping ([NSDictionary]?) -> Void) {
        guard let url = URL(string : "https://api.themoviedb.org/3/search/movie?api_key=4cb1eeab94f45affe2536f2c684a5c9e&query=\(title)")  else { print("Error unwraping Url") ; return}
        
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            guard let unwrappedData = data else { print("Error getting data"); return  }
            do {
                if let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as? NSDictionary {
                    if let apps = responseJSON.value(forKeyPath: "results") as? [NSDictionary] {
                        print(apps)
                        completion(apps)
                    }
                }
            } catch {
                completion(nil)
                print("Error getttig API data: \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
    
    func fetchApDetail( completion:@escaping (NSDictionary?) -> Void) {
        guard let url = URL(string : "https://api.themoviedb.org/3/movie/321528?api_key=4cb1eeab94f45affe2536f2c684a5c9e")  else { print("Error unwraping Url") ; return}
        
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            guard let unwrappedData = data else { print("Error getting data"); return  }
            do {
                if let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as? NSDictionary {
                    let apps = responseJSON
                    print(apps)
                    completion(apps)
                }
            } catch {
                completion(nil)
                print("Error getttig API data: \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
    
    
    func fetchApDetails( id: Int ,completion:@escaping (NSDictionary?) -> Void) {
        guard let url = URL(string : "https://api.themoviedb.org/3/movie/\(id)?api_key=4cb1eeab94f45affe2536f2c684a5c9e")  else { print("Error unwraping Url") ; return}
        
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            guard let unwrappedData = data else { print("Error getting data"); return  }
            do {
                if let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as? NSDictionary {
                    let apps = responseJSON
                    print(apps)
                    completion(apps)
                }
            } catch {
                completion(nil)
                print("Error getttig API data: \(error.localizedDescription)")
            }
        }
        dataTask.resume()
        
    }

}
