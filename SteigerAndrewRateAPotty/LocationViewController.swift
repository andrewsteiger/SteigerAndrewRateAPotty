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
    @IBOutlet weak var scrollViewMain: UIScrollView!
    @IBOutlet var lblHeader: UILabel!
    @IBOutlet weak var viewRatings: UIView!
    @IBOutlet weak var btnAllReviews: UIButton!
    @IBOutlet weak var viewRatingAverage: RatingStars!
    @IBOutlet weak var viewRatingAccessibiliy: RatingStars!
    @IBOutlet weak var viewRatingCleanliness: RatingStars!
    @IBOutlet weak var viewRatingAtmosphere: RatingStars!
    @IBOutlet weak var btnShowLocationDetails: UIButton!
    
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
    var currentPottyId: String?
    var apiClient = ApiClient()
    let currentUser = "mockInTosh" //TODO:  replace with authenticated user
    
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
    
    // MARK: - btnSubmitClick()
    /// Create a review
    ///
    /// - Parameters:
    ///   - sender: The star button that was selected
    @IBAction func btnSubmitClick(_ sender: Any) {
        if currentPotty == nil { return }
        
        //begin form validation.  note, a blank comment is allowed
        
        //user can only leave one comment
        for i in 0...currentPotty!.ratings.count - 1 {
            if currentPotty!.ratings[i].author == currentUser {
                let alertController =
                UIAlertController(title: "Potty Has Been Reviewed",
                                  message: "Only one review allowed.",
                                  preferredStyle: .alert)
                let okAction = AlertActions.okAction
                alertController.addAction(okAction)
                self.present(alertController,
                             animated: true,
                             completion: nil)
                return
            }
        }
        
        let accessibility = viewNewRatingAccessibility.getRating()
        let cleanliness = viewNewRatingCleanliness.getRating()
        let atmosphere = viewNewRatingAtmosphere.getRating()
        
        //alert the user if no ratings were given
        if accessibility == 0 ||
            cleanliness == 0 ||
            atmosphere == 0 {
            let alertController =
            UIAlertController(title: "No Ratings Given",
                              message: "Still leave review?",
                              preferredStyle: .alert)
            let warningCancelAction = AlertActions.cancelAction
            let okAction = UIAlertAction(title: "Ok", style: .default) {_ in
                let confirmAlertController = UIAlertController(title: "Review Created",
                                                               message: nil,
                                                               preferredStyle: .alert)
                    confirmAlertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                        self.scrollViewMain.layoutIfNeeded()
                        self.scrollViewMain.setContentOffset(CGPoint(x: 0, y: -self.scrollViewMain.adjustedContentInset.top), animated: true)
                    }))
                    self.present(confirmAlertController,
                                 animated: true,
                                 completion: {self.createReview(self.currentUser, accessibility: accessibility, cleanliness: cleanliness, atmosphere: atmosphere, comment: self.tvNewReviewComments.text)})
                }
            alertController.addAction(warningCancelAction)
            alertController.addAction(okAction)
            self.present(alertController,
                         animated: true,
                         completion: nil)
        }
        else {
            let confirmAlertController = UIAlertController(title: "Review Created",
                                                           message: nil,
                                                           preferredStyle: .alert)
            confirmAlertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self.scrollViewMain.layoutIfNeeded()
                self.scrollViewMain.setContentOffset(CGPoint(x: 0, y: -self.scrollViewMain.adjustedContentInset.top), animated: true)
            }
                ))
                self.present(confirmAlertController,
                             animated: true,
                             completion: {self.createReview(self.currentUser, accessibility: accessibility, cleanliness: cleanliness, atmosphere: atmosphere, comment: self.tvNewReviewComments.text)})
        }
    }
    
    // MARK: - createReview()
    /// Calls the API via post method to create a review
    ///
    /// - Parameters:
    ///   - 'some user data': Various review data used to post review
    private func createReview(_ author: String, accessibility: Int, cleanliness: Int, atmosphere: Int, comment: String) {
        apiClient.postNewReview(
            currentPotty!.id,
            author: author,
            ratingAccessibility: accessibility,
            ratingCleanlines: cleanliness,
            ratingAtmosphere: atmosphere,
            comment: comment)
        
        // adjust ui after review has been left
        lblLeaveAReview.isHidden = true
        contentViewNewReview.isHidden = true
        setupHeader()
        self.view.layoutIfNeeded()
    }
    
    // MARK: - showAllReviews()
    /// Sends user to TableVCReviews to see all reviews
    ///
    /// - Parameters:
    ///   - sender: The star button that was selected\
    @IBAction func showAllReviews(_ sender: Any) {
        if let activePotty = currentPotty {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TableVCReviews") as! TableVCReviews
            vc.currentPotty = activePotty
            if let navigationController = self.navigationController {
                navigationController.pushViewController(vc, animated: true)
            }
        }
    }
    
    
    // MARK: - showLocationDetails()
    /// Sends user to TableVCReviews to see all reviews
    ///
    /// - Parameters:
    ///   - sender: The star button that was selected\
    @IBAction func showLocationDetails(_ sender: Any) {
        if let activePotty = currentPotty {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LocationDetailsViewController") as! LocationDetailsViewController
            vc.currentPotty = activePotty
            if let navigationController = self.navigationController {
                navigationController.pushViewController(vc, animated: true)
            }
        }
    }
    
    // MARK: - showTopFullReview()
    /// Sends user to ReviewDetailViewController to see all review details
    ///
    /// - Parameters:
    ///   - sender: The star button that was selected
    @IBAction func showTopFullReview(_ sender: Any) {
        if let topRatedReview = currentPotty?.getTopRated() {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReviewDetailViewController") as! ReviewDetailViewController
            vc.currentReview = topRatedReview
            if let navigationController = self.navigationController {
                navigationController.pushViewController(vc, animated: true)
            }
        }
    }
    
    // MARK: - setupHeader()
    private func setupHeader() {
        if let activePotty = currentPotty {
            //refresh current potty
            currentPotty = apiClient.getPottyByID(activePotty.id)
                
            lblHeader.text = currentPotty!.title
            viewRatingAverage.setRating(currentPotty!.getAverageRating(""))
            viewRatingAverage.disable(true)
            btnAllReviews.setTitle("(" + String(currentPotty!.ratings.count) + ")", for: .normal)
            viewRatingAccessibiliy.setRating(currentPotty!.getAverageRating(AppConfig.RatingTypes.accessibility))
            viewRatingAccessibiliy.disable(true)
            viewRatingCleanliness.setRating(currentPotty!.getAverageRating(AppConfig.RatingTypes.cleanliness))
            viewRatingCleanliness.disable(true)
            viewRatingAtmosphere.setRating(currentPotty!.getAverageRating(AppConfig.RatingTypes.atmosphere))
            viewRatingAtmosphere.disable(true)
            viewRatings.layoutIfNeeded()
            viewRatings.layer.addSublayer(DrawBorderLayer(viewRatings, inset: 14))
        }
    }
    
    // MARK: - setupTopReview()
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
        else {
            //no top review
            lblReviewTitle.text = "No Reviews"
            lblReviewComment.text = "Leave a review below!"
            viewRatingStars.disable(true)
            btnReadFullReview.setTitle("", for: .normal)
            viewRatingReviewSupport.isHidden = true
            contentViewReviewMain.layoutIfNeeded()
            contentViewReviewMain.layer.addSublayer(DrawBorderLayer(contentViewReviewMain, inset: 14))
        }
    }
    
    // MARK: - setupNewReview()
    private func setupNewReview() {
        contentViewNewReview.layoutIfNeeded()
        contentViewNewReview.layer.addSublayer(DrawBorderLayer(contentViewNewReview, inset: 14))
        tvNewReviewComments.layer.borderColor = UIColor.cgGray
        tvNewReviewComments.layer.borderWidth = 1
        tvNewReviewComments.text = ""
    }
}
