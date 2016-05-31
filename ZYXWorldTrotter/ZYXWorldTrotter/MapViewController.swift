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
    var anns: [MKPointAnnotation] = []
    var annIndex: Int = 0
    
    
    override func loadView()
    {
        mapView = MKMapView()
        
        view = mapView
        mapView.delegate = self
        
        locationManager = CLLocationManager()
        
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let hyvridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        let segementedControl = UISegmentedControl(items: [standardString, satelliteString, hyvridString])
        
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
        
        var ann = MKPointAnnotation()
        var annLoc = CLLocationCoordinate2DMake(39.9, -75.9)
        ann.coordinate = annLoc
        ann.title = "Here I am"
        ann.subtitle = "Ann0"
        mapView.addAnnotation(ann)
        anns.append(ann)
        
        ann = MKPointAnnotation()
        annLoc = CLLocationCoordinate2DMake(39.7, -75.7)
        ann.coordinate = annLoc
        ann.title = "Here I am"
        ann.subtitle = "Ann1"
        mapView.addAnnotation(ann)
        anns.append(ann)
        
        ann = MKPointAnnotation()
        annLoc = CLLocationCoordinate2DMake(39.5, -75.5)
        ann.coordinate = annLoc
        ann.title = "Here I am"
        ann.subtitle = "Ann2"
        mapView.addAnnotation(ann)
        anns.append(ann)
        
        let button = UIButton(type: .System)
        button.backgroundColor = UIColor.grayColor()
        button.setTitle("NextLoc", forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(buttonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        button.translatesAutoresizingMaskIntoConstraints=false
        self.view.addSubview(button)
        let widthConstraint = button.widthAnchor.constraintEqualToAnchor(nil, constant: 100.0)
        let heightConstraint = button.heightAnchor.constraintEqualToAnchor(nil, constant: 35.0)
        let horizontalConstraint = button.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor)
        let verticalConstraint = button.bottomAnchor.constraintEqualToAnchor(self.bottomLayoutGuide.topAnchor, constant: -28.0)
        NSLayoutConstraint.activateConstraints([widthConstraint, heightConstraint, horizontalConstraint, verticalConstraint])
        
    }
    
    func buttonAction(sender: UIButton!)
    {
        mapView.showAnnotations([anns[annIndex]], animated: true)
        annIndex = (annIndex + 1) % 3
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        print("MapViewController loaded its view.")
    }
    
    func mapTypeChanged(segControl: UISegmentedControl)
    {
        switch segControl.selectedSegmentIndex
        {
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
    
    func showLocButton(sender: UIButton!)
    {
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation)
    {
        let zoomedIncurrentLocation = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 500, 500)
        mapView.setRegion(zoomedIncurrentLocation, animated: true)
    }
}
