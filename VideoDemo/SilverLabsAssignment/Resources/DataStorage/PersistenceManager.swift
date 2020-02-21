//
//  PersistenceManager.swift
//  SilverLabsAssignment
//
//  Created by Bandish Kumar on 20/02/20.
//  Copyright © 2020 Bandish Kumar. All rights reserved.
//

import UIKit
import CoreData

final class PersistentManager {
    
    //MARK: Properties
    static let shareInstance = PersistentManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: Initializer
    private init() {}
    
    //MARK: Methods
    func saveImage(data: Data?,url: String) {
        let imageInstance = Image(context: context)
        imageInstance.img = data
        imageInstance.url = url
            
        do {
            try context.save()
            print(Strings.image_saved)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchImage(url: String) -> [Image]? {
        var fetchingImage: [Image]?
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Strings.image_entity)
        fetchRequest.predicate = NSPredicate(format: "url == %@", url)
        do {
            fetchingImage = try context.fetch(fetchRequest) as? [Image]
        } catch {
            print(Strings.fetch_image_error)
        }
        
        return fetchingImage
    }
}
