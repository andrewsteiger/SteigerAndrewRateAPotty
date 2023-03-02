//
//  MapsViewController.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 2/27/23.
//

import UIKit
import GoogleMaps

class MapsViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapViewMain: GMSMapView!
    
    var appData: AppData = AppData()
    let locationManager = CLLocationManager()
    var markers: [GMSMarker] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        mapViewMain.delegate = self
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        mapViewMain.camera = camera
        
        setupMarkers()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            print("No access")
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            print("Access")
        case .restricted, .denied:
            print("Denied")
        @unknown default:
            break
        }
    }
    
    private func setupMarkers() {
        
        //create markers, add to local array markers
        for i in 0...appData.AppPotties.count - 1 {
            let currentPotty = appData.AppPotties[i]
            // creates markers from app data
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: currentPotty.latitude, longitude: currentPotty.longitude)
            marker.title = currentPotty.title
            marker.snippet = currentPotty.snippit
            marker.map = mapViewMain
            marker.iconView = currentPotty.iconView
            marker.tracksViewChanges = true
            markers.append(marker)
        }
        
        self.view.addSubview(mapViewMain)
    }
    
}

extension MapsViewController: GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let index = markers.firstIndex(of: marker) {
            let tappedState = appData.AppPotties[index]
            return true
        }
        return false
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        UIView.animate(withDuration: 5.0, animations: { () -> Void in
            mapView.tintColor = .blue
        }, completion: {(finished) in
            // Stop tracking view changes to allow CPU to idle.
            for i in self.markers {
                i.tracksViewChanges = false
            }
        })
    }    /* handles Info Window tap */
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("didTapInfoWindowOf")
    }
    
    /* handles Info Window long press */
    func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf marker: GMSMarker) {
        print("didLongPressInfoWindowOf")
    }
    
    /* set a custom Info Window */
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let view = UIView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 70))
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 6
        
        let lbl1 = UILabel(frame: CGRect.init(x: 8, y: 8, width: view.frame.size.width - 16, height: 15))
        lbl1.text = "Hi there!"
        view.addSubview(lbl1)
        
        let lbl2 = UILabel(frame: CGRect.init(x: lbl1.frame.origin.x, y: lbl1.frame.origin.y + lbl1.frame.size.height + 3, width: view.frame.size.width - 16, height: 15))
        lbl2.text = "I am a custom info window."
        lbl2.font = UIFont.systemFont(ofSize: 14, weight: .light)
        view.addSubview(lbl2)
        
        return view
    }}
