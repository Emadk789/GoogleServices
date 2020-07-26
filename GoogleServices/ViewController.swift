//
//  ViewController.swift
//  GoogleServices
//
//  Created by Emad Albarnawi on 23/07/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit;
import GoogleMaps;
import CoreLocation;

class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    var locationManager: CLLocationManager?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configerMap()
    }
    
    fileprivate func configerMap() {
        let camera = GMSCameraPosition.camera(withLatitude: 21.3891, longitude: 39.8579, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.delegate = self;
        self.view.addSubview(mapView)
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 21.3891, longitude: 39.8579)
        marker.title = "Makkah"
        marker.snippet = "SA"
        marker.map = mapView
        
        mapView.mapStyle = try! GMSMapStyle(jsonString: MapStyle.kMapStyle);
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        mapView.settings.compassButton = true;
        mapView.settings.indoorPicker = true;
        mapView.settings.myLocationButton = true;
        mapView.isMyLocationEnabled = true;
        
        mapView.settings.scrollGestures = true;
        mapView.settings.zoomGestures = true;
        
        self.view = mapView
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
      print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
    }
    
    
}

