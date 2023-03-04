//
//  MapsViewController.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 2/27/23.
//

import UIKit
import GoogleMaps

class MapsViewController: UIViewController {
    
    @IBOutlet weak var mapViewMain: GMSMapView!
    
    var appData: AppData = AppData()
    let locationManager = CLLocationManager()
    var camera = GMSCameraPosition()
    var cameraZoom: Float = 6
    var userLastLocation: CLLocation?
    var markers: [GMSMarker] = []
    var btnZoomIn = UIButton()
    var btnZoomOut = UIButton()
    var currentPotty: Potty?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //attach delegates
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        mapViewMain.delegate = self
        
        //configure camera and map settings
        camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: cameraZoom)
        mapViewMain.camera = camera
        mapViewMain.settings.myLocationButton = true
        mapViewMain.settings.compassButton = true
        mapViewMain.settings.scrollGestures = true
        mapViewMain.settings.zoomGestures   = true
        mapViewMain.settings.tiltGestures   = false
        mapViewMain.settings.rotateGestures = false
        
        //setup work
        setupMarkers()
        setupControls()
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
    
    @objc func btnZoomAction(sender: UIButton!) {
        switch sender {
        case btnZoomIn:
            cameraZoom = cameraZoom + 1
            mapViewMain.animate(toZoom: cameraZoom)
        case btnZoomOut:
            cameraZoom = cameraZoom - 1
            mapViewMain.animate(toZoom: cameraZoom)
        default:
            return
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
    
    private func setupControls() {
        let buttonDimensions: CGFloat = 40
        let buttonWidthBaseline: CGFloat = 20
        let buttonHeightBaseline: CGFloat = 150
        
        // create the zoom buttons
        btnZoomIn.frame = CGRect(x: buttonWidthBaseline, y: buttonHeightBaseline, width: buttonDimensions, height: buttonDimensions)
        let btnZoomInView = UIView(frame: btnZoomIn.frame)
        let btnZoomInBorder = DrawBorderLayer(btnZoomInView, inset: 0)
        btnZoomIn.layer.addSublayer(btnZoomInBorder)
        btnZoomIn.addSubview(AppAssets.ImageViews.ZoomIn40)
        btnZoomIn.contentVerticalAlignment = .fill
        btnZoomIn.contentHorizontalAlignment = .fill
        btnZoomIn.addTarget(self, action: #selector(btnZoomAction), for: .touchUpInside)
        btnZoomIn.tintColor = UIColor.blueFocus
        self.mapViewMain.addSubview(btnZoomIn)
        
        btnZoomOut.frame = CGRect(x: buttonWidthBaseline, y:buttonHeightBaseline + 1.5 * buttonDimensions, width: buttonDimensions, height: buttonDimensions)
        let btnZoomOutView = UIView(frame: btnZoomOut.frame)
        let btnZoomOutBorder = DrawBorderLayer(btnZoomOutView, inset: 0)
        btnZoomOut.layer.addSublayer(btnZoomOutBorder)
        btnZoomOut.addSubview(AppAssets.ImageViews.ZoomOut40)
        btnZoomOut.contentVerticalAlignment = .fill
        btnZoomOut.contentHorizontalAlignment = .fill
        btnZoomOut.addTarget(self, action: #selector(btnZoomAction), for: .touchUpInside)
        btnZoomOut.tintColor = UIColor.blueFocus
        self.mapViewMain.addSubview(btnZoomOut)
    }
}
