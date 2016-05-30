//
//  CustomViewController.swift
//  ZYXWorldTrotter
//
//  Created by 卓酉鑫 on 16/5/30.
//  Copyright © 2016年 卓酉鑫. All rights reserved.
//

import UIKit
import WebKit

class CustomViewController: UIViewController {
    
    var wkView: WKWebView!
    
    override func loadView() {
        wkView = WKWebView()
        
        view = wkView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = NSURL(string: "https://www.bignerdranch.com/") {
            let request = NSURLRequest(URL: url)
            wkView.loadRequest(request)
        }
    }
    
}
