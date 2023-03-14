//
//  NewLocationViewController.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 3/13/23.
//

import UIKit

class NewLocationViewController: UIViewController {
    
    // header view
    @IBOutlet var contentViewMain: UIView!
    @IBOutlet weak var scrollViewMain: UIScrollView!
    @IBOutlet var lblHeader: UILabel!
    
    // main create location view
    @IBOutlet weak var contentViewCreateLocation: UIView!
    @IBOutlet weak var lblLocationAddress: UILabel!
    @IBOutlet weak var tfLocation: UITextField!
    @IBOutlet weak var btnCurrentLocation: UIButton!
    
    var currentLocation: GMSPlace?
    var selectedFromDestination: GMSPlace?
    var selectedToDestination: GMSPlace?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func getCurrentLocation(_ sender: Any) {
        
    }
}
