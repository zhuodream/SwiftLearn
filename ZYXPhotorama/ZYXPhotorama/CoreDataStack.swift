//
//  CoreDataStack.swift
//  ZYXPhotorama
//
//  Created by 卓酉鑫 on 16/6/3.
//  Copyright © 2016年 卓酉鑫. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack
{
    let managerObjectModelName: String
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource(self.managerObjectModelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    private var applicationDocumentsDirectory: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls.first!
    }()
    
    lazy var mainQueueContext: NSManagedObjectContext = {
       
        let moc = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        moc.persistentStoreCoordinator = self.persistentStoreCoordinator
        moc.name = "Main Queue Context (UI Context)"
        
        return moc
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
       
        var coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let pathComponent = "\(self.managerObjectModelName).sqlite"
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent(pathComponent)
        
        let store = try! coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        
        return coordinator
    }()
    
    required init(modelName: String)
    {
        managerObjectModelName = modelName
    }
    
    func saveChanges() throws
    {
        var error: ErrorType?
        mainQueueContext.performBlockAndWait { 
            
            if self.mainQueueContext.hasChanges
            {
                do {
                    try self.mainQueueContext.save()
                }
                catch let saveError {
                    error = saveError
                }
            }
        }
        
        if let error = error
        {
            throw error
        }
    }
}
