//
//  LocationDetailsViewController.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 3/14/23.
//

import UIKit

class LocationDetailsViewController: UIViewController {
    
    //header view
    @IBOutlet var contentViewMain: UIView!
    @IBOutlet var lblHeader: UILabel!
    
    //checkboxes
    @IBOutlet weak var contentViewDetails: UIView!
    @IBOutlet weak var cbPetRestArea: CheckBox!
    @IBOutlet weak var cbWheelchairAccessible: CheckBox!
    @IBOutlet weak var cbVending: CheckBox!
    @IBOutlet weak var cbBabyChangingTables: CheckBox!
    @IBOutlet weak var cbGenderNeutral: CheckBox!
    @IBOutlet weak var cbRestaurants: CheckBox!
    @IBOutlet weak var cbGas: CheckBox!
    
    var currentPotty: Potty?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        if let activePotty = currentPotty {
            lblHeader.text = activePotty.title
            
            cbPetRestArea.isDisabled(true)
            cbWheelchairAccessible.isDisabled(true)
            cbVending.isDisabled(true)
            cbBabyChangingTables.isDisabled(true)
            cbGenderNeutral.isDisabled(true)
            cbRestaurants.isDisabled(true)
            cbGas.isDisabled(true)
            
            if activePotty.details.count != 7 { return }
            if activePotty.details[0] == 1 { cbPetRestArea.isChecked = true }
            if activePotty.details[1] == 1 { cbWheelchairAccessible.isChecked = true }
            if activePotty.details[2] == 1 { cbVending.isChecked = true }
            if activePotty.details[3] == 1 { cbBabyChangingTables.isChecked = true }
            if activePotty.details[4] == 1 { cbGenderNeutral.isChecked = true }
            if activePotty.details[5] == 1 { cbRestaurants.isChecked = true }
            if activePotty.details[6] == 1 { cbGas.isChecked = true }
            
            contentViewDetails.layoutIfNeeded()
            contentViewDetails.layer.addSublayer(DrawBorderLayer(contentViewDetails, inset: 14))
        }
    }
}
