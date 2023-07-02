//
//  CoreData+Helpers.swift
//  PodcastApp
//
//  Created by Asude Nisa Tıraş on 2.07.2023.
//

import Foundation
import CoreData
import UIKit
 let appDelegate = UIApplication.shared.delegate as! AppDelegate
 let context =  appDelegate.persistentContainer.viewContext
struct CoreDataController {
    static func addCoreData(model: PodcastCoreData, podcast: Podcast){
        model.feedUrl = podcast.feedUrl
        model.artistName = podcast.artistName
        model.artworkUrl600 = podcast.artworkUrl600
        model.trackName = podcast.trackName
        appDelegate.saveContext()
    }
    static func deleteCoreData(array: [PodcastCoreData], podcast: Podcast){
        let value = array.filter({$0.feedUrl == podcast.feedUrl})
        context.delete(value.first!)
        appDelegate.saveContext()
    }
    
    static func fetchCoreData(fetchRequest: NSFetchRequest<PodcastCoreData>, completion: @escaping ([PodcastCoreData]) -> Void){
        
        do{
            let result = try context.fetch(fetchRequest)
            completion(result)
        }catch {
            
        }
    }
}
