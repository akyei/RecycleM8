//
//  MapViewController.swift
//  RecycleM8
//
//  Created by Alexander Kyei on 4/9/16.
//  Copyright © 2016 Alexander Kyei. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class MapViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
    override func viewDidLoad() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        let camera = GMSCameraPosition.cameraWithLatitude(-33.86, longitude: 151.20, zoom: 6)
        let mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.myLocationEnabled = true
        self.view = mapView
        
        let marker = GMSMarker()
        
        marker.position = locationManager.location!.coordinate//CLLocationCoordinate2DMake(-33.86, 151.20)
        marker.title = "Your Location"
        //marker.snippet = ""
        marker.map = mapView
        
    }
    
}
