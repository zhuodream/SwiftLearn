//
//  ImageStore.swift
//  ZYXHomepwner
//
//  Created by 卓酉鑫 on 16/6/2.
//  Copyright © 2016年 卓酉鑫. All rights reserved.
//

import UIKit

class ImageStore
{
    let cache = NSCache()
    
    func setImage(image: UIImage, forKey key:String)
    {
        cache.setObject(image, forKey: key)
    }
    
    func imageForKey(key: String) -> UIImage?
    {
        return cache.objectForKey(key) as? UIImage
    }
    
    func deleteImageForKey(key: String)
    {
        cache.removeObjectForKey(key)
    }
}
