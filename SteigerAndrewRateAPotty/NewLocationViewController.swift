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
    
    //checkboxes
    @IBOutlet weak var cbPetRestArea: CheckBox!
    @IBOutlet weak var cbWheelchairAccessible: CheckBox!
    @IBOutlet weak var cbVending: CheckBox!
    @IBOutlet weak var cbBabyChangingTables: CheckBox!
    @IBOutlet weak var cbGenderNeutral: CheckBox!
    @IBOutlet weak var cbRestaurants: CheckBox!
    @IBOutlet weak var cbGas: CheckBox!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    var currentLocation: GMSPlace?
    var placesClient = GMSPlacesClient()
    let geocoder = CLGeocoder()
    let apiClient = ApiClient()
    
    var currentLatitude: Double?
    var currentLongitude: Double?
    var currentSnippet: String?
    var newDetails: [Int] = []
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
    
    // MARK: - submitLocation()
    /// Calls API to create a new location
    ///
    /// - Parameters:
    ///   - sender: The location button
    @IBAction func submitLocation(_ sender: Any) {
        //validate
        if currentLatitude == nil || currentLongitude == nil { return }
        if tfLocation.text == "" || tfLocation.text == nil {
            let confirmAlertController = UIAlertController(title: "Please Specify Location Name",
                                                           message: nil,
                                                           preferredStyle: .alert)
            confirmAlertController.addAction(AlertActions.okAction)
            self.present(confirmAlertController,
                         animated: true,
                         completion: nil)
            return
        }
        
        //create poorly designed code of amenities
        newDetails.removeAll()
        if cbPetRestArea.isChecked { newDetails.append(1) } else { newDetails.append(0) }
        if cbWheelchairAccessible.isChecked { newDetails.append(1) } else { newDetails.append(0) }
        if cbVending.isChecked { newDetails.append(1) } else { newDetails.append(0) }
        if cbBabyChangingTables.isChecked { newDetails.append(1) } else { newDetails.append(0) }
        if cbGenderNeutral.isChecked { newDetails.append(1) } else { newDetails.append(0) }
        if cbRestaurants.isChecked { newDetails.append(1) } else { newDetails.append(0) }
        if cbGas.isChecked { newDetails.append(1) } else { newDetails.append(0) }
        
        
        apiClient.postNewPotty(latitude: currentLatitude!, longitude: currentLongitude!, title: tfLocation.text!, snippet: currentSnippet ?? "", details: newDetails)
        
        let confirmAlertController = UIAlertController(title: "Potty Created",
                                                       message: nil,
                                                       preferredStyle: .alert)
        confirmAlertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        self.present(confirmAlertController,
                     animated: true,
                     completion: {self.navigationController?.popToRootViewController(animated: true)})
        
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
        btnCurrentLocation.tintColor = UIColor.systemBlue
        btnCurrentLocation.setTitle("", for: .normal)
        btnCurrentLocation.layer.borderColor = UIColor.cgGray
        btnCurrentLocation.layer.borderWidth = 1
        btnCurrentLocation.layer.cornerRadius = 8
        
        contentViewCreateLocation.layoutIfNeeded()
        //TODO: border seems to not want to cooperate with height, maybe take this out of a scroll view
        contentViewCreateLocation.layer.addSublayer(DrawBorderLayer(contentViewCreateLocation, inset: 14))
    }
}
