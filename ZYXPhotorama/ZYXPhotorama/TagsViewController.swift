//
//  TagsViewController.swift
//  ZYXPhotorama
//
//  Created by 卓酉鑫 on 16/6/3.
//  Copyright © 2016年 卓酉鑫. All rights reserved.
//

import UIKit
import CoreData

class TagsViewController: UITableViewController {
    
    var store: PhotoStore!
    var photo: Photo!
    
    var selectedIndexPaths = [NSIndexPath]()
    
    let tagDataSource = TagDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = tagDataSource
        tableView.delegate = self
        updateTags()
    }
    
    func updateTags()
    {
        let tags = try! store.fetchMainQueueTags(predicate: nil, sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
        tagDataSource.tags = tags
        
        for tag in photo.tags
        {
            if let index = tagDataSource.tags.indexOf(tag)
            {
                let indexPath = NSIndexPath(forRow: index, inSection: 0)
                selectedIndexPaths.append(indexPath)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let tag = tagDataSource.tags[indexPath.row]
        
        if let index = selectedIndexPaths.indexOf(indexPath)
        {
            selectedIndexPaths.removeAtIndex(index)
        }
        else
        {
            selectedIndexPaths.append(indexPath)
        }
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if selectedIndexPaths.indexOf(indexPath) != nil
        {
            cell.accessoryType = .Checkmark
        }
        else
        {
            cell.accessoryType = .None
        }
    }
}
