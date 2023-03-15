//
//  NewLocationViewController.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 3/13/23.
//

import UIKit
import GooglePlaces

class NewLocationViewController: UIViewController {
    
    //header view
    @IBOutlet var contentViewMain: UIView!
    @IBOutlet weak var scrollViewMain: UIScrollView!
    @IBOutlet var lblHeader: UILabel!
    
    //main create location view
    @IBOutlet weak var contentViewCreateLocation: UIView!
    @IBOutlet weak var lblLocationAddress: UILabel!
    @IBOutlet weak var tfLocation: UITextField!
    @IBOutlet weak var btnCurrentLocation: UIButton!
    
    var currentLocation: GMSPlace?
    var selectedFromDestination: GMSPlace?
    var selectedToDestination: GMSPlace?
    var placesClient = GMSPlacesClient()
    let geocoder: CLGeocoder = CLGeocoder()
    var currentLatitude: Double?
    var currentLongitude: Double?
    var spinnerViewChild = SpinnerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - getCurrentLocation()
    /// Invokes a SpinnerViewController while querying for location details
    ///
    /// - Parameters:
    ///   - sender: The location button
    @IBAction func getCurrentLocation(_ sender: Any) {
        createSpinnerView(spinnerViewChild)
        if currentLatitude == nil || currentLongitude == nil { return }
        geocoder.reverseGeocodeLocation(CLLocation(latitude: currentLatitude!, longitude: currentLongitude!), completionHandler:
                                            {(placemarks, error) in
            self.processLocation(placemarks, error: error)
        })
        
    }
    
    // MARK: - processLocation()
    /// The callback method from getCurrentLocation().  Terminates the SpinnerViewController.  Processes the location received
    /// from the query and updates tfLocation with the results.
    ///
    /// - Parameters:
    ///   - placemarks: Possible CLPlacemark returned from the query
    ///   - error: Possible error from the query
    func processLocation(_ placemarks: [CLPlacemark]?, error: Error?) {
        //remove spinner view after query
        self.removeSpinnerView(self.spinnerViewChild)
        
        if (error != nil)
        {
            self.tfLocation.text = "No location found, impressive!"
            print("Error getting location: ", error as Any)
        }
        if let placemarks = placemarks, let placemark = placemarks.first {
            if placemarks.count > 0 {
                print(placemark.name as Any)
                var addressString : String = ""
                if placemark.subLocality != nil {
                    addressString = addressString + placemark.subLocality! + ", "
                }
                if placemark.thoroughfare != nil {
                    addressString = addressString + placemark.thoroughfare! + ", "
                }
                if placemark.locality != nil {
                    addressString = addressString + placemark.locality! + ", "
                }
                if placemark.country != nil {
                    addressString = addressString + placemark.country! + ", "
                }
                if placemark.postalCode != nil {
                    addressString = addressString + placemark.postalCode!
                }
                if placemark.name != nil { //sometimes this is the same as postal code
                    if !addressString.contains(placemark.name!) {
                        addressString = placemark.name! + ", " + addressString
                    }
                }
                
                print(addressString)
                self.tfLocation.text = addressString
            }
        }
    }
    
    // MARK: - setupView()
    func setupView() {
        btnCurrentLocation.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        btnCurrentLocation.setImage(AppAssets.Icons.NewMarker, for: .normal)
        btnCurrentLocation.contentVerticalAlignment = .fill
        btnCurrentLocation.contentHorizontalAlignment = .fill
        btnCurrentLocation.tintColor = UIColor.blueFocus
        btnCurrentLocation.setTitle("", for: .normal)
        btnCurrentLocation.layer.borderColor = UIColor.cgGray
        btnCurrentLocation.layer.borderWidth = 1
        btnCurrentLocation.layer.cornerRadius = 8
    }
}
