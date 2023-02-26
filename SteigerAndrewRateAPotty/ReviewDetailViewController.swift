//
//  ReviewDetailViewController.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 2/25/23.
//

import UIKit

class ReviewDetailViewController: UIViewController {
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var lblDateCreated: UILabel!
    @IBOutlet weak var viewRatingStars: RatingStars!
    @IBOutlet weak var viewRatingReviewSupport: RatingReviewSupport!
    @IBOutlet weak var lblReviewComment: UILabel!
    
    var currentReview: PottyReview?
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        if let review = currentReview {
            lblHeader.text = "Full Review - " + String(review.author)
            lblHeader.font = UIFont.boldSystemFont(ofSize: 17)
            lblReviewComment.text = "\t\"" + (review.comment) + "\""
            viewRatingStars.drawView(drawFromRight: false)
            viewRatingStars.setRating(review.getAverageRating())
            viewRatingStars.disable(true)
            viewRatingReviewSupport.setUpVotes(review.upVotes)
            viewRatingReviewSupport.setDownVotes(review.downVotes)
            dateFormatter.dateFormat = "dd/MM/YYYY HH:mm"
            lblDateCreated.font = UIFont.italicSystemFont(ofSize: 14)
            if let dateCreated = review.dateTimeCreated {
                print(dateCreated)
                lblDateCreated.text = dateFormatter.string(from: dateCreated)
            }
            viewContent.layoutIfNeeded()
            viewContent.layer.addSublayer(DrawBorderLayer(viewContent, inset: 14))
        }
    }

}
