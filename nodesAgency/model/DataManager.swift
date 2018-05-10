//
//  DataManager.swift
//  nodesAgency
//
//  Created by Administrator on 05/05/2018.
//  Copyright © 2018 mahesh lad. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class DataManager {
    
    public   static let sharedInstance = DataManager()
    
    private init() {} //This prevents others from using the default '()' initializer for this class.
    
    
    func saveLike( id : Int, title: String, image: NSData) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Likes", in: context)
        let newLikes = NSManagedObject(entity: entity!, insertInto: context)
        newLikes.setValue(id, forKey: "id")
        newLikes.setValue(true, forKey: "like")
        newLikes.setValue(title, forKey: "title")
        newLikes.setValue(image, forKey: "image")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
        
        
        
    }
    
    func getLikes() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Likes")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "title") as! String)
                
            }
            
        } catch {
            
            print("Failed")
        }
    }
    
    func deleteLike(id: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Likes")
        let predicate = NSPredicate(format: "id == %i", id)
        
        // Assigns the predicate to the request
        request.predicate = predicate
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                context.delete(data) //for delete
            }
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
        } catch {
            
            print("Failed")
        }
    }
    
    func isLiked(id: Int) -> Bool{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Likes")
        //   request.returnsObjectsAsFaults = false
        let predicate = NSPredicate(format: "id == %i", id)
        
        // Assigns the predicate to the request
        request.predicate = predicate
        do {
            let result = try context.fetch(request)
            if result.count > 0 {
                return true
            } else {
                return false
            }
        } catch {
            
            print("Failed")
        }
        return false
    }
    
}
