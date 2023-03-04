//
//  LocationViewController.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 3/4/23.
//

import UIKit

class LocationViewController: UIViewController {

    @IBOutlet var contentViewMain: UIView!
    @IBOutlet var lblHeader: UILabel!
    @IBOutlet weak var viewRatings: RatingStars!
    @IBOutlet weak var btnAllReviews: UIButton!
    
    var currentPotty: Potty?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        if let activePotty = currentPotty {
            lblHeader.text = activePotty.title
        }
    }

}
