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
    @IBOutlet weak var lblReadFullReview: UILabel!
    
    //create review view
    @IBOutlet weak var lblLeaveAReview: UILabel!
    @IBOutlet weak var contentViewNewReview: UIView!
    @IBOutlet weak var viewNewRatingAccessibility: RatingStars!
    @IBOutlet weak var viewNewRatingCleanliness: RatingStars!
    @IBOutlet weak var viewNewRatingAtmosphere: RatingStars!
    @IBOutlet weak var tvNewReviewComments: UITextView!
    @IBOutlet weak var contentViewComment: UIView!
    @IBOutlet weak var btnSubmitReview: UIButton!
    
    var currentPotty: Potty?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up view to observe keyboard show/hide
        self.keyboardWillHideOnTap()
        self.viewWillLayoutWithKeyboard()
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        tvNewReviewComments.delegate = self
        //let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))


        setupHeader()
        setupTopReview()
        setupNewReview()
        
        //view.addGestureRecognizer(tap)
    }
    
    private func setupHeader() {
        if let activePotty = currentPotty {
            lblHeader.text = activePotty.title
            lblHeader.font = UIFont.boldSystemFont(ofSize: 18)
            viewRatingAverage.setRating(activePotty.getAverageRating(""))
            viewRatingAverage.disable(true)
            btnAllReviews.titleLabel!.text = "(" + String(activePotty.ratings.count) + ")"
            viewRatingAccessibiliy.setRating(activePotty.getAverageRating(AppConfig.RatingTypes.accessibility))
            viewRatingAccessibiliy.disable(true)
            viewRatingCleanliness.setRating(activePotty.getAverageRating(AppConfig.RatingTypes.cleanliness))
            viewRatingCleanliness.disable(true)
            viewRatingAtmosphere.setRating(activePotty.getAverageRating(AppConfig.RatingTypes.atmosphere))
            viewRatingAtmosphere.disable(true)
            viewRatings.layoutIfNeeded()
            viewRatings.layer.addSublayer(DrawBorderLayer(viewRatings, inset: 14))
            
            
            var contactOwnerString = NSMutableAttributedString(string: "Are you the owner?")
            if activePotty.owner != nil {
                contactOwnerString = NSMutableAttributedString(string: "Contact " + activePotty.owner!)
            }
            contactOwnerString.addAttributes([NSAttributedString.Key.font : UIFont.italicSystemFont(ofSize: 12), NSAttributedString.Key.underlineStyle : NSUnderlineStyle.thick.rawValue, NSAttributedString.Key.foregroundColor: UIColor.blueFocus], range: NSRange.init(location: 0, length: contactOwnerString.length))
            btnContactOwner.setAttributedTitle(contactOwnerString, for: .normal)
        }
    }

    private func setupTopReview() {
        if let topRatedReview = currentPotty?.getTopRated() {
            lblReviewTitle.text = "Top Rated Review: " + "\(topRatedReview.author)"
            lblReviewTitle.textColor = UIColor.blueDark
            lblReviewTitle.font = UIFont.systemFont(ofSize: 14)
            lblReviewComment.text = "\t\"" + (topRatedReview.comment) + "\""
            lblReviewComment.font = UIFont.systemFont(ofSize: 12)
            viewRatingStars.disable(true)
            let readFullReviewString = NSMutableAttributedString(string: "Full Review", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue])
            lblReadFullReview.font = UIFont.italicSystemFont(ofSize: 12)
            lblReadFullReview.textColor = UIColor.blueFocus
            lblReadFullReview.attributedText = readFullReviewString
            viewRatingStars.setRating(topRatedReview.getAverageRating())
            viewRatingReviewSupport.setUpVotes(topRatedReview.upVotes)
            viewRatingReviewSupport.setDownVotes(topRatedReview.downVotes)
            contentViewReviewMain.layoutIfNeeded()
            contentViewReviewMain.layer.addSublayer(DrawBorderLayer(contentViewReviewMain, inset: 14))
        }
    }
    
    private func setupNewReview() {
        lblLeaveAReview.font = UIFont.boldSystemFont(ofSize: 18)
        contentViewNewReview.layoutIfNeeded()
        contentViewNewReview.layer.addSublayer(DrawBorderLayer(contentViewNewReview, inset: 14))
        tvNewReviewComments.layer.borderColor = UIColor.cgGray
        tvNewReviewComments.layer.borderWidth = 1
        contentViewComment.layoutIfNeeded()
        contentViewComment.layer.addSublayer(DrawBorderLayer(contentViewComment, inset: 14))
        //tvNewReviewComments.text = ""
    }
}
