//
//  ItemStore.swift
//  ZYXHomepwner
//
//  Created by 卓酉鑫 on 16/6/1.
//  Copyright © 2016年 卓酉鑫. All rights reserved.
//

import UIKit

class ItemStore
{
    var allItems = [Item]()
    
    func createItem() -> Item
    {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    func removeItem(item: Item)
    {
        if let index = allItems.indexOf(item)
        {
            allItems.removeAtIndex(index)
        }
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int)
    {
        if fromIndex == toIndex
        {
            return
        }
        
        let movedItem = allItems[fromIndex]
        
        allItems.removeAtIndex(fromIndex)
        
        allItems.insert(movedItem, atIndex: toIndex)
    }
    
}
