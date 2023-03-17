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
    
    let locationManager = CLLocationManager()
    var camera = GMSCameraPosition()
    var cameraZoom: Float = 6
    var userLastLocation: CLLocation?
    var markers: [GMSMarker] = []
    var btnZoomIn = UIButton()
    var btnZoomOut = UIButton()
    var currentPotty: Potty?
    var isTrackingLocation: Bool = false
    
    var newLocationControl: UIControl?
    var newLocationLatitude: Double?
    var newLocationLongitude: Double?
    var newLocationMarker: GMSMarker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //attach delegates and delegate processes
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapViewMain.delegate = self
        
        //configure camera and map settings
        camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: cameraZoom)
        mapViewMain.camera = camera
        mapViewMain.settings.compassButton = true
        mapViewMain.settings.scrollGestures = true
        mapViewMain.settings.zoomGestures   = true
        mapViewMain.settings.tiltGestures   = false
        mapViewMain.settings.rotateGestures = false
        
        //setup work
        setupControls()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupMarkers()
    }
    
    // MARK: - btnZoomAction()
    /// Either zoom in or out depending on type of button click
    ///
    /// - Parameters:
    ///   - sender: The star button that was selected
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
    
    // MARK: - buttonAction()
    /// Define the actions when stars inside of `RatingStars` are clicked.
    ///
    /// Checking one star will automatically check the others below it to retain a sequential selection.
    ///
    /// Unchecking one star will automatically uncheck the others above it to retain a sequential selection.
    ///
    /// - Parameters:
    ///   - sender: The star button that was selected
    func showNewMarker(latitude: Double, longitude: Double) {
        newLocationLatitude = latitude
        newLocationLongitude = longitude
        if removeNewLocationMarker() == false {
            // create new marker
            let newMarker = GMSMarker()
            newMarker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            newMarker.map = mapViewMain
            newMarker.iconView = AppAssets.ImageViews.NewMarker35
            newMarker.tracksViewChanges = true
            newLocationMarker = newMarker
            markers.append(newLocationMarker!)
            mapViewMain.selectedMarker = newLocationMarker
        }
    }
    
    // MARK: - setupMarkers()
    private func setupMarkers() {
        //clean u
        for marker in markers {
            marker.map = nil
        }
        
        markers.removeAll()
        
        //create markers, add to local array markers
        for i in 0..<AppData.sharedData.AppPotties.count {
            let currentPotty = AppData.sharedData.AppPotties[i]
            // creates markers from app data
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: currentPotty.latitude, longitude: currentPotty.longitude)
            marker.title = currentPotty.title
            marker.snippet = currentPotty.snippet
            marker.map = mapViewMain
            marker.iconView = currentPotty.iconView
            marker.tracksViewChanges = true
            markers.append(marker)
        }
        
        self.view.addSubview(mapViewMain)
    }
    
    // MARK: - setupControls()
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
        btnZoomIn.tintColor = UIColor.systemBlue
        self.mapViewMain.addSubview(btnZoomIn)
        
        btnZoomOut.frame = CGRect(x: buttonWidthBaseline, y:buttonHeightBaseline + 1.5 * buttonDimensions, width: buttonDimensions, height: buttonDimensions)
        let btnZoomOutView = UIView(frame: btnZoomOut.frame)
        let btnZoomOutBorder = DrawBorderLayer(btnZoomOutView, inset: 0)
        btnZoomOut.layer.addSublayer(btnZoomOutBorder)
        btnZoomOut.addSubview(AppAssets.ImageViews.ZoomOut40)
        btnZoomOut.contentVerticalAlignment = .fill
        btnZoomOut.contentHorizontalAlignment = .fill
        btnZoomOut.addTarget(self, action: #selector(btnZoomAction), for: .touchUpInside)
        btnZoomOut.tintColor = UIColor.systemBlue
        self.mapViewMain.addSubview(btnZoomOut)
    }
}
