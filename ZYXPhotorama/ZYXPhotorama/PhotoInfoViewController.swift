//
//  PhotoInfoViewController.swift
//  ZYXPhotorama
//
//  Created by 卓酉鑫 on 16/6/3.
//  Copyright © 2016年 卓酉鑫. All rights reserved.
//

import UIKit

class PhotoInfoViewController: UIViewController
{
    @IBOutlet weak var imageView: UIImageView!
    
    var photo: Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }
    
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchImageForPhoto(photo) { (result) in
            
            switch result
            {
            case let .Success(image):
                NSOperationQueue.mainQueue().addOperationWithBlock({ 
                    self.imageView.image = image
                })
            case let .Failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowTags"
        {
            let navController = segue.destinationViewController as! UINavigationController
            let tagController = navController.topViewController as! TagsViewController
            
            tagController.store = store
            tagController.photo = photo
        }
    }
    
}
