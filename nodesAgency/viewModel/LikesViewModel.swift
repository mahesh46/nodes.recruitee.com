//
//  LikesViewModel.swift
//  nodesAgency
//
//  Created by Administrator on 05/05/2018.
//  Copyright © 2018 mahesh lad. All rights reserved.
//

import UIKit
import CoreData

class LikesViewModel: NSObject {
    
    var likes : [Likes]?
    
    func getLikes() -> [Likes]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Likes")
        request.returnsObjectsAsFaults = false
        do {
            
            let result = try context.fetch(request)
            return result as! [Likes]
            
        } catch {
            
            print("Failed")
        }
        return likes!
    }
    
}
