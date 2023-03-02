//
//  Extensions.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 2/23/23.
//

import Foundation
import UIKit
import GoogleMaps

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

extension MapsViewController {
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        guard status == .authorizedWhenInUse else {
            return
        }
        locationManager.requestLocation()
        
        mapViewMain.isMyLocationEnabled = true
        mapViewMain.settings.myLocationButton = true
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.first else {
                return
            }
            
            mapViewMain.camera = GMSCameraPosition(
                target: location.coordinate,
                zoom: 15,
                bearing: 0,
                viewingAngle: 0)
        }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print(error)
    }
}
