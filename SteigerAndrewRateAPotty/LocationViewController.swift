//
//  LocationViewController.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 3/4/23.
//

import UIKit

class LocationViewController: UIViewController, UITextViewDelegate {

    //header view
    @IBOutlet var contentViewMain: UIView!
    @IBOutlet var lblHeader: UILabel!
    @IBOutlet weak var viewRatings: UIView!
    @IBOutlet weak var btnAllReviews: UIButton!
    @IBOutlet weak var viewRatingAverage: RatingStars!
    @IBOutlet weak var viewRatingAccessibiliy: RatingStars!
    @IBOutlet weak var viewRatingCleanliness: RatingStars!
    @IBOutlet weak var viewRatingAtmosphere: RatingStars!
    @IBOutlet weak var btnContactOwner: UIButton!
    
    //top review view
    @IBOutlet weak var contentViewReviewMain: UIView!
    @IBOutlet weak var lblReviewTitle: UILabel!
    @IBOutlet weak var lblReviewComment: UILabel!
    @IBOutlet weak var viewRatingStars: RatingStars!
    @IBOutlet weak var viewRatingReviewSupport: RatingReviewSupport!
    @IBOutlet weak var btnReadFullReview: UIButton!
    
    //create review view
    @IBOutlet weak var lblLeaveAReview: UILabel!
    @IBOutlet weak var contentViewNewReview: UIView!
    @IBOutlet weak var viewNewRatingAccessibility: RatingStars!
    @IBOutlet weak var viewNewRatingCleanliness: RatingStars!
    @IBOutlet weak var viewNewRatingAtmosphere: RatingStars!
    @IBOutlet weak var tvNewReviewComments: UITextView!
    @IBOutlet weak var btnSubmitReview: UIButton!
    
    var currentPotty: Potty?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up view to observe keyboard show/hide
        self.keyboardWillHideOnTap()
        self.viewWillLayoutWithKeyboard()
        tvNewReviewComments.delegate = self
        setupHeader()
        setupTopReview()
        setupNewReview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupHeader()
        setupTopReview()
        setupNewReview()
    }
    
    
    
    //handles when user selects btnAllReviews
    @IBAction func showAllReviews(_ sender: Any) {
        if let activePotty = currentPotty {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TableVCReviews") as! TableVCReviews
            vc.currentPotty = activePotty
            if let navigationController = self.navigationController {
                navigationController.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func showTopFullReview(_ sender: Any) {
        if let topRatedReview = currentPotty?.getTopRated() {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReviewDetailViewController") as! ReviewDetailViewController
            vc.currentReview = topRatedReview
            if let navigationController = self.navigationController {
                navigationController.pushViewController(vc, animated: true)
            }
        }
    }
    
    private func setupHeader() {
        if let activePotty = currentPotty {
            lblHeader.text = activePotty.title
            viewRatingAverage.setRating(activePotty.getAverageRating(""))
            viewRatingAverage.disable(true)
            btnAllReviews.setTitle("(" + String(activePotty.ratings.count) + ")", for: .normal)
            viewRatingAccessibiliy.setRating(activePotty.getAverageRating(AppConfig.RatingTypes.accessibility))
            viewRatingAccessibiliy.disable(true)
            viewRatingCleanliness.setRating(activePotty.getAverageRating(AppConfig.RatingTypes.cleanliness))
            viewRatingCleanliness.disable(true)
            viewRatingAtmosphere.setRating(activePotty.getAverageRating(AppConfig.RatingTypes.atmosphere))
            viewRatingAtmosphere.disable(true)
            viewRatings.layoutIfNeeded()
            viewRatings.layer.addSublayer(DrawBorderLayer(viewRatings, inset: 14))
            
            
            var contactOwnerString: String = "Are you the owner?"
            if activePotty.owner != nil {
                contactOwnerString = "Contact the Owner"
            }
            btnContactOwner.setTitle(contactOwnerString, for: .normal)
        }
    }

    private func setupTopReview() {
        if let topRatedReview = currentPotty?.getTopRated() {
            lblReviewTitle.text = "Top Rated Review: " + "\(topRatedReview.author)"
            lblReviewComment.text = "\"" + (topRatedReview.comment) + "\""
            viewRatingStars.disable(true)
            btnReadFullReview.setTitle("Read Full Review", for: .normal)
            viewRatingStars.setRating(topRatedReview.getAverageRating())
            viewRatingReviewSupport.currentReview = topRatedReview
            viewRatingReviewSupport.setUpVotes(topRatedReview.upVotes)
            viewRatingReviewSupport.setDownVotes(topRatedReview.downVotes)
            viewRatingReviewSupport.setUserVote()
            contentViewReviewMain.layoutIfNeeded()
            contentViewReviewMain.layer.addSublayer(DrawBorderLayer(contentViewReviewMain, inset: 14))
        }
    }
    
    private func setupNewReview() {
        contentViewNewReview.layoutIfNeeded()
        contentViewNewReview.layer.addSublayer(DrawBorderLayer(contentViewNewReview, inset: 14))
        tvNewReviewComments.layer.borderColor = UIColor.cgGray
        tvNewReviewComments.layer.borderWidth = 1
        tvNewReviewComments.text = ""
    }
}
