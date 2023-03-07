//
//  RatingReviewSupport.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 2/25/23.
//
//  Custom UIView to represent support for a review, using UpVotes and DownVotes
//  Buttons will populate from the right
//  Width of view should be at least 50

import UIKit

class RatingReviewSupport: UIView {
    let upVote = UIButton()
    let lblUpVotes = UILabel()
    var upVoteCount: Int = 0
    let downVote = UIButton()
    let lblDownVotes = UILabel()
    var downVoteCount: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    /// Setup the `RatingReviewSupport` view
    private func setupView() {
        let buttonDimensions: CGFloat = self.frame.height
        let buttonWidthBaseline: CGFloat = self.frame.width - buttonDimensions
        let buttonHeightBaseline: CGFloat = 0
        
        // create the support thumbs
        upVote.frame = CGRect(x: buttonWidthBaseline - 3 * buttonDimensions, y: buttonHeightBaseline, width: buttonDimensions, height: buttonDimensions)
        upVote.setImage(AppAssets.Icons.ThumbUp, for: .normal)
        upVote.contentVerticalAlignment = .fill
        upVote.contentHorizontalAlignment = .fill
        upVote.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.addSubview(upVote)
        lblUpVotes.frame = CGRect(x: buttonWidthBaseline - 2 * buttonDimensions, y: buttonHeightBaseline, width: buttonDimensions, height: buttonDimensions)
        lblUpVotes.text = "(" + String(upVoteCount) + ")"
        lblUpVotes.textColor = upVote.tintColor
        lblUpVotes.font = UIFont.systemFont(ofSize: 10)
        lblUpVotes.textAlignment = .left
        self.addSubview(lblUpVotes)
        downVote.frame = CGRect(x: buttonWidthBaseline - buttonDimensions, y: buttonHeightBaseline, width: buttonDimensions, height: buttonDimensions)
        downVote.setImage(AppAssets.Icons.ThumbDown, for: .normal)
        downVote.contentVerticalAlignment = .fill
        downVote.contentHorizontalAlignment = .fill
        downVote.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.addSubview(downVote)
        lblDownVotes.frame = CGRect(x: buttonWidthBaseline, y: buttonHeightBaseline, width: buttonDimensions, height: buttonDimensions)
        lblDownVotes.text = "(" + String(downVoteCount) + ")"
        lblDownVotes.textColor = downVote.tintColor
        lblDownVotes.font = UIFont.systemFont(ofSize: 10)
        lblDownVotes.textAlignment = .left
        self.addSubview(lblDownVotes)
        
        // set this so that background blends with parent view background i.e. tableview selection color
        self.backgroundColor = UIColor.opaqueBackground
    }
    
    @objc func buttonAction(sender: UIButton!) {
        // little bit of reflection
        print(String(describing: sender.currentImage) + " was clicked!")
    }
    
    func disable(_ shouldDisable: Bool) {
        upVote.isEnabled = !shouldDisable
        downVote.isEnabled = !shouldDisable
    }
    
    func setUpVotes(_ upVotes: Int) {
        upVoteCount = upVotes
        lblUpVotes.text = "(" + String(upVoteCount) + ")"
    }
    
    func setDownVotes(_ downVotes: Int) {
        downVoteCount = downVotes
        lblDownVotes.text = "(" + String(downVoteCount) + ")"
    }
}
