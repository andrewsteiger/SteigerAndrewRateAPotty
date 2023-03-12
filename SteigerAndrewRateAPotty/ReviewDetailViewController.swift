//
//  ReviewDetailViewController.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 2/25/23.
//

import UIKit

class ReviewDetailViewController: UIViewController {
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var viewRatings: UIView!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var lblDateCreated: UILabel!
    @IBOutlet weak var viewRatingAccessibility: RatingStars!
    @IBOutlet weak var viewRatingCleanliness: RatingStars!
    @IBOutlet weak var viewRatingAtmosphere: RatingStars!
    @IBOutlet weak var viewRatingReviewSupport: RatingReviewSupport!
    @IBOutlet weak var lblReviewComment: UILabel!
    
    var currentReview: PottyReview?
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let review = currentReview {
            lblHeader.text = "Full Review - " + String(review.author)
            
            viewRatingAccessibility.setRating(review.ratingAccessibility)
            viewRatingAccessibility.disable(true)
            viewRatingCleanliness.setRating(review.ratingCleanliness)
            viewRatingCleanliness.disable(true)
            viewRatingAtmosphere.setRating(review.ratingAtmosphere)
            viewRatingAtmosphere.disable(true)
            viewRatings.layoutIfNeeded()
            viewRatings.layer.addSublayer(DrawBorderLayer(viewRatings, inset: 14))
            
            lblReviewComment.text = "\t\"" + (review.comment) + "\""
            viewRatingReviewSupport.currentReview = review
            viewRatingReviewSupport.setUpVotes(review.upVotes)
            viewRatingReviewSupport.setDownVotes(review.downVotes)
            viewRatingReviewSupport.setUserVote()
            dateFormatter.dateFormat = "dd/MM/YYYY HH:mm"
            lblDateCreated.font = UIFont.italicSystemFont(ofSize: 12)
            if let dateCreated = review.dateTimeCreated {
                lblDateCreated.text = "Review Created: " + dateFormatter.string(from: dateCreated)
            }
            viewContent.layoutIfNeeded()
            viewContent.layer.addSublayer(DrawBorderLayer(viewContent, inset: 14))
        }
    }
}
