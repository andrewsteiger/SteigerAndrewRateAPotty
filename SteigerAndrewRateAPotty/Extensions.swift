//
//  Extensions.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 2/23/23.
//

import Foundation
import UIKit
import GoogleMaps

// MARK: - Date

/// An extension the native `Date` object
extension Date {
    /// Create a date from specified parameters because swift can't do this by itself...
    ///
    /// - Parameters:
    ///   - year: The desired year
    ///   - month: The desired month
    ///   - day: The desired day
    /// - Returns: A `Date` object
    static func from(year: Int, month: Int, day: Int, hour: Int, minute: Int) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        return calendar.date(from: dateComponents) ?? nil
    }
}

// MARK: - UIColor

/// An extension to the native `UIColor` object to add colors 
extension UIColor {
    // dont forget to divide standard rgb by 255 smh
    static let blueFocus = UIColor(red: 0.0, green: 0.506, blue: 0.541, alpha: 1.0)
    static let blueDark = UIColor(red: 0.059, green: 0.298, blue: 0.459, alpha: 1.0);
    static let blueLight = UIColor(red: 0.859, green: 0.929, blue: 0.953, alpha: 1.0);
    static let bluePurple = UIColor(red: 0.157, green: 0.192, blue: 0.286, alpha: 1.0);
    static let starYellow = UIColor(red: 0.961, green: 0.725, blue: 0.259, alpha: 1.0);
    static let starGray = UIColor(red: 0.294, green: 0.294, blue: 0.294, alpha: 1.0);
    static let opaqueBackground = UIColor(white: 1, alpha: 0.0)
    
    static let cgGray = starGray.cgColor;
}

// MARK: - UIViewController

///use for custom keyboard functionality
extension UIViewController {
    //call this in viewDidLoad to automatically dismiss the keyboard when tapping.  must set proper delegate in viewDidLoad to self
    func keyboardWillHideOnTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

///use to move view when keyboard shows
extension UIViewController {
    func viewWillLayoutWithKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

///use to utilize a spinner view
extension UIViewController {
    // add the spinner view controller
    func createSpinnerView(_ child: SpinnerViewController) {
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        }
    }
    
    // remove the spinner view controller
    func removeSpinnerView(_ child: SpinnerViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}

// MARK: - CLLocationManagerDelegate

extension MapsViewController: CLLocationManagerDelegate {
    ///set usage based on authorization settings
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied: // Setting option: Never
            print("LocationManager didChangeAuthorization denied")
        case .notDetermined: // Setting option: Ask Next Time
            print("LocationManager didChangeAuthorization notDetermined")
        case .authorizedWhenInUse: // Setting option: While Using the App
            print("LocationManager didChangeAuthorization authorizedWhenInUse")
            locationManager.requestLocation()
        case .authorizedAlways: // Setting option: Always
            print("LocationManager didChangeAuthorization authorizedAlways")
            locationManager.requestLocation()
        case .restricted: // Restricted by parental control
            print("LocationManager didChangeAuthorization restricted")
        default:
            print("LocationManager didChangeAuthorization")
        }
    }
    
    ///update location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        self.mapViewMain.isMyLocationEnabled = true
        self.mapViewMain.settings.myLocationButton = true
        
        userLastLocation = location
        
        if isTrackingLocation {
            //show location in (almost) real time
            camera = GMSCameraPosition(
                target: location.coordinate,
                zoom: 17,
                bearing: 0,
                viewingAngle: 0)
            mapViewMain.animate(to: camera)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LocationManager didFailWithError \(error.localizedDescription)")
        if let error = error as? CLError, error.code == .denied {
            // location updates are not authorized.
            // To prevent forever looping of `didFailWithError` callback
            locationManager.stopMonitoringSignificantLocationChanges()
            return
        }
    }
}

// MARK: - GMSMapViewDelegate

extension MapsViewController: GMSMapViewDelegate {
    ///user tapped the map
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        self.showNewMarker(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
    
    ///user tapped location button
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool{
        if isTrackingLocation {
            isTrackingLocation = false
        }
        else {
            isTrackingLocation = true
        }
        return true
    }
    
    ///map became idle
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        UIView.animate(withDuration: 5.0, animations: { () -> Void in
            mapView.tintColor = .blue
        }, completion: {(finished) in
            //stop tracking view changes to allow CPU to idle.
            for i in self.markers {
                i.tracksViewChanges = false
            }
        })
    }
    
    ///user tapped info window
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        //get the object related to the marker selected
        if let index = markers.firstIndex(of: marker) {
            if AppData.sharedData.AppPotties.count - 1 < index {
                //user tapped a new location window
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewLocationViewController") as! NewLocationViewController
                vc.currentLatitude = self.newLocationLatitude
                vc.currentLongitude = self.newLocationLongitude
                if let navigationController = self.navigationController {
                    navigationController.pushViewController(vc, animated: true)
                }
            }
            else {
                //user tapped a known location window
                let currentPotty = AppData.sharedData.AppPotties[index]
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LocationViewController") as! LocationViewController
                vc.currentPotty = currentPotty
                if let navigationController = self.navigationController {
                    navigationController.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    ///shows a view when the user clicks a marker, on the marker
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        //get the object related to the marker selected
        if let index = markers.firstIndex(of: marker) {
            if AppData.sharedData.AppPotties.count - 1 < index {
                //user clicked on a new location
                let infoWindowView = UIView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 70))
                infoWindowView.backgroundColor = UIColor.white
                infoWindowView.layer.cornerRadius = 6
                
                let lblHeader = UILabel(frame: CGRect.init(x: 8, y: 8, width: infoWindowView.frame.size.width - 16, height: 20))
                lblHeader.text = "Uncharted Potty"
                lblHeader.textColor = .blueFocus
                infoWindowView.addSubview(lblHeader)
                
                let lblContent = UILabel(frame: CGRect.init(x: lblHeader.frame.origin.x, y: lblHeader.frame.origin.y + lblHeader.frame.size.height + 3, width: infoWindowView.frame.size.width - 16, height: 15))
                lblContent.text = "Click to create"
                lblContent.font = UIFont.systemFont(ofSize: 14, weight: .light)
                infoWindowView.addSubview(lblContent)
                
                //set the current view to the marker selected, centered on the marker, reset to readable zoom
                cameraZoom = 9
                self.mapViewMain.animate(to: GMSCameraPosition(latitude: marker.position.latitude, longitude: marker.position.longitude, zoom: cameraZoom))
                return infoWindowView
            }
            else {
                //remove any new location marker created
                let _ = removeNewLocationMarker()
                
                //user clicked on an existing location
                let selectedPotty = AppData.sharedData.AppPotties[index]
                
                let infoWindowView = UIView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 70))
                infoWindowView.backgroundColor = UIColor.white
                infoWindowView.layer.cornerRadius = 6
                
                let lblHeader = UILabel(frame: CGRect.init(x: 8, y: 8, width: infoWindowView.frame.size.width - 16, height: 20))
                lblHeader.text = selectedPotty.title
                lblHeader.textColor = .blueFocus
                infoWindowView.addSubview(lblHeader)
                
                let lblContent = UILabel(frame: CGRect.init(x: lblHeader.frame.origin.x, y: lblHeader.frame.origin.y + lblHeader.frame.size.height + 3, width: infoWindowView.frame.size.width - 16, height: 15))
                lblContent.text = selectedPotty.snippet //TODO: this should probably show the ratingalert
                lblContent.font = UIFont.systemFont(ofSize: 14, weight: .light)
                infoWindowView.addSubview(lblContent)
                
                //set the current view to the marker selected, centered on the marker, reset to readable zoom
                cameraZoom = 9
                self.mapViewMain.animate(to: GMSCameraPosition(latitude: camera.target.latitude, longitude: camera.target.longitude, zoom: cameraZoom))
                return infoWindowView
            }
        }
        return nil
    }
    
    // MARK: - removeNewLocationMarker()
    /// Removes a user selected potential new pin
    func removeNewLocationMarker()  -> Bool {
        if newLocationMarker != nil {
            //undo previous selection
            if let lastMarker = markers.last {
                if lastMarker == newLocationMarker {
                    lastMarker.map = nil
                    newLocationMarker = nil
                    return true
                }
            }
        }
        return false
    }
}
