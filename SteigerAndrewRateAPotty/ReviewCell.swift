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
    
    class var reuseIdentifier: String {
        get {
            return "ReviewCell"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        lblReviewTitle.textColor = UIColor.blueDark
        contentViewMain.layer.addSublayer(DrawBorderLayer(contentViewMain, inset: 14))
        viewRatingStars.disable(true)
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func setRating(rating: Int) {
        viewRatingStars.setRating(rating)
    }

}
