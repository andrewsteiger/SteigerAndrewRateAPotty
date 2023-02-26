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
        contentViewMain.layoutIfNeeded()
        contentViewMain.layer.addSublayer(DrawBorderLayer(contentViewMain, inset: 14))
        viewRatingStars.disable(true)
        viewRatingStars.drawView(drawFromRight: true)
        let readFullReviewString = NSMutableAttributedString(string: "Read Full Review", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue])
        lblReadFullReview.font = UIFont.italicSystemFont(ofSize: 16)
        lblReadFullReview.textColor = UIColor.blueFocus
        lblReadFullReview.attributedText = readFullReviewString
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func setRating(_ rating: Int) {
        viewRatingStars.setRating(rating)
    }
    
    func setUpVotes(_ upVotes: Int) {
        viewRatingReviewSupport.setUpVotes(upVotes)
    }
    
    func setDownVotes(_ downVotes: Int) {
        viewRatingReviewSupport.setDownVotes(downVotes)
    }

}
