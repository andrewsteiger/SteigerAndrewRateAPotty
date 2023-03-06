//
//  ReviewCell.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 2/24/23.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var contentViewMain: UIView!
    @IBOutlet weak var lblReviewTitle: UILabel!
    @IBOutlet weak var lblReviewComment: UILabel!
    @IBOutlet weak var viewRatingStars: RatingStars!
    @IBOutlet weak var viewRatingReviewSupport: RatingReviewSupport!
    @IBOutlet weak var lblReadFullReview: UILabel!
    
    class var reuseIdentifier: String {
        get {
            return "ReviewCell"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        lblReviewTitle.textColor = UIColor.blueDark
        lblReviewTitle.font = UIFont.systemFont(ofSize: 14)
        lblReviewComment.font = UIFont.systemFont(ofSize: 12)
        contentViewMain.layoutIfNeeded()
        contentViewMain.layer.addSublayer(DrawBorderLayer(contentViewMain, inset: 14))
        viewRatingStars.disable(true)
        let readFullReviewString = NSMutableAttributedString(string: "Full Review", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue])
        lblReadFullReview.font = UIFont.italicSystemFont(ofSize: 12)
        lblReadFullReview.textColor = UIColor.blueFocus
        lblReadFullReview.attributedText = readFullReviewString
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
