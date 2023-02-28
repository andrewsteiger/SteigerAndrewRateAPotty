//
//  MapsViewController.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 2/27/23.
//

import UIKit
import GoogleMaps

class MapsViewController: UIViewController {
    
    var appData: AppData = AppData()
    var mapView = GMSMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupMarkers()
    }
    
    private func setupMarkers() {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        
        for i in 0...appData.AppPotties.count - 1 {
            let currentPotty = appData.AppPotties[i]
            // creates markers from app data
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: currentPotty.latitude, longitude: currentPotty.longitude)
            marker.title = currentPotty.title
            marker.snippet = currentPotty.snippit
            marker.map = mapView
            self.view.addSubview(mapView)
        }
        
    }

}
