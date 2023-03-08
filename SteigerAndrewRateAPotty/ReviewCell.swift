//
//  ReviewCell.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 2/24/23.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var contentViewMain: UIView!
    @IBOutlet weak var layoutView: UIView!
    @IBOutlet weak var lblReviewTitle: UILabel!
    @IBOutlet weak var lblReviewComment: UILabel!
    @IBOutlet weak var viewRatingStars: RatingStars!
    @IBOutlet weak var btnReadFullReview: UIButton!
    @IBOutlet weak var viewRatingReviewSupport: RatingReviewSupport!
    
    //reference for inputting an action on button tap from the parent
    var buttonAction: ((Any) -> Void)?
    
    class var reuseIdentifier: String {
        get {
            return "ReviewCell"
        }
    }    
    
    func setupCell() {
        // Initialization code
        viewRatingStars.disable(true)
    }
    
    func setRating(_ rating: Double) {
        viewRatingStars.setRating(rating)
    }
    
    func setUpVotes(_ upVotes: Int) {
        viewRatingReviewSupport.setUpVotes(upVotes)
    }
    
    func setDownVotes(_ downVotes: Int) {
        viewRatingReviewSupport.setDownVotes(downVotes)
    }

}
