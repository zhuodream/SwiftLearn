//
//  FlickrAPI.swift
//  ZYXPhotorama
//
//  Created by 卓酉鑫 on 16/6/3.
//  Copyright © 2016年 卓酉鑫. All rights reserved.
//

import Foundation
import CoreData

enum FlickError: ErrorType
{
    case InvaildJSONData
}

enum Method: String
{
    case RecentPhotos = "flickr.photos.getRecent"
}

enum PhotosResult
{
    case Success([Photo])
    case Failure(ErrorType)
}

struct FlickrAPI
{
    private static let baseURLString = "https://api.flickr.com/services/rest"
    private static let APIKey = "a6d819499131071f158fd740860a5a88"
    
    private static let dateformatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    private static func flickrAPI(method method: Method, parameters: [String:String]?) -> NSURL
    {
        let componets = NSURLComponents(string: baseURLString)
        
        var queryItems = [NSURLQueryItem]()
        
        let baseParams = ["method" : method.rawValue, "format" : "json", "nojsoncallback" : "1", "api_key" : APIKey]
        
        for (key, value) in baseParams
        {
            let item = NSURLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters
        {
            for (key, value) in additionalParams
            {
                let item = NSURLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        componets?.queryItems = queryItems
        
        return (componets?.URL)!
    }
    
    private static func photoFromJSONObject(json: [String : AnyObject], inContext context: NSManagedObjectContext) -> Photo?
    {
        guard let photoID = json["id"] as? String, title = json["title"] as? String, dateString = json["dateTaken"] as? String, photoURLString = json["url_h"] as? String, url = NSURL(string: photoURLString), dateTaken = dateformatter.dateFromString(dateString)
        else
        {
            return nil
        }
        
        let fetchRequest = NSFetchRequest(entityName: "Photo")
        let predicate = NSPredicate(format: "photoID == \(photoID)")
        fetchRequest.predicate = predicate
        
        var fetchedPhotos: [Photo]!
        context.performBlockAndWait { 
            fetchedPhotos = try! context.executeFetchRequest(fetchRequest) as! [Photo]
        }
        
        if fetchedPhotos.count > 0
        {
            return fetchedPhotos.first
        }
        
        var photo: Photo!
        context.performBlockAndWait { 
            photo = NSEntityDescription.insertNewObjectForEntityForName("Photo", inManagedObjectContext: context) as! Photo
            photo.title = title
            photo.photoID = photoID
            photo.remoteURL = url
            photo.dateTaken = dateTaken
        }
        
        return photo
    }
    
    static func recentPhotosURL() -> NSURL
    {
        return flickrAPI(method: .RecentPhotos, parameters: ["extras" : "url_h,date_taken"])
    }
    
    static func photosFromJSONData(data: NSData, inContext context: NSManagedObjectContext) -> PhotosResult
    {
        do {
            let jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            
            guard let jsonDictionary = jsonObject as? [NSObject:AnyObject], photos = jsonDictionary["photos"] as? [String:AnyObject], photosArray = photos["photo"] as? [[String:AnyObject]]
            else
            {
                return .Failure(FlickError.InvaildJSONData)
            }
            
            var finalPhotos = [Photo]()
            
            for photoJSON in photosArray
            {
                if let photo = photoFromJSONObject(photoJSON, inContext: context)
                {
                    finalPhotos.append(photo)
                }
            }
            
            if finalPhotos.count == 0 && photosArray.count == 0
            {
                return .Failure(FlickError.InvaildJSONData)
            }
            
            return .Success(finalPhotos)
        }
        catch let error {
            return .Failure(error)
        }
    }
}





