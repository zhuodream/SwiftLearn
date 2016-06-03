//
//  Photo.swift
//  ZYXPhotorama
//
//  Created by 卓酉鑫 on 16/6/3.
//  Copyright © 2016年 卓酉鑫. All rights reserved.
//

import UIKit
import CoreData


class Photo: NSManagedObject {

    var image: UIImage?
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        title = ""
        photoID = ""
        remoteURL = NSURL()
        photoKey = NSUUID().UUIDString
        dateTaken = NSDate()
    }
}
