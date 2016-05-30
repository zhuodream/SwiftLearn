//
//  MapViewController.swift
//  ZYXWorldTrotter
//
//  Created by 卓酉鑫 on 16/5/30.
//  Copyright © 2016年 卓酉鑫. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    
    override func loadView() {
        mapView = MKMapView()
        
        view = mapView
        mapView.delegate = self
        
        locationManager = CLLocationManager()
        
        let segementedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segementedControl.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        segementedControl.selectedSegmentIndex = 0
        
        segementedControl.addTarget(self, action: #selector(mapTypeChanged(_:)), forControlEvents: .ValueChanged)
        
        segementedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segementedControl)
        
        let topConstraint = segementedControl.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 8)
        
        let margins = view.layoutMarginsGuide
        
        let leadingConstraint = segementedControl.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor)
        let trailingConstraint = segementedControl.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor)
        
        topConstraint.active = true
        leadingConstraint.active = true
        trailingConstraint.active = true
        
        let currentLocationButton = UIButton(type: .System)
        currentLocationButton.translatesAutoresizingMaskIntoConstraints = false
        currentLocationButton.setTitle("Where Am I?", forState: .Normal)
        currentLocationButton.backgroundColor = UIColor.greenColor()
        currentLocationButton.addTarget(self, action: #selector(showLocButton(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(currentLocationButton)
        
        let topButtonConstraint = currentLocationButton.topAnchor.constraintEqualToAnchor(segementedControl.bottomAnchor, constant: 8)
        let leadingButtonConstraint = currentLocationButton.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor)
        let trailingButtonConstraint = currentLocationButton.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor)
        topButtonConstraint.active = true
        leadingButtonConstraint.active = true
        trailingButtonConstraint.active = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViewController loaded its view.")
    }
    
    func mapTypeChanged(segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .Standard
        case 1:
            mapView.mapType = .Hybrid
        case 3:
            mapView.mapType = .Satellite
        default:
            break
        }
    }
    
    func showLocButton(sender: UIButton!) {
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        let zoomedIncurrentLocation = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 500, 500)
        mapView.setRegion(zoomedIncurrentLocation, animated: true)
        print("aaaaaaaaaaaa")
    }
}
