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
        let viewWidth = self.frame.width
        
        // create the support thumbs
        upVote.frame = CGRect(x: viewWidth - 90, y: 0, width: 25, height: 25)
        upVote.setImage(AppIcons.ThumbUp, for: .normal)
        upVote.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        upVote.tintColor = UIColor.blueDark
        self.addSubview(upVote)
        lblUpVotes.frame = CGRect(x: viewWidth - 65, y: 0, width: 40, height: 25)
        lblUpVotes.text = "(" + String(upVoteCount) + ")"
        lblUpVotes.textColor = UIColor.blueDark
        lblUpVotes.font = UIFont.systemFont(ofSize: 12)
        lblUpVotes.textAlignment = .left
        self.addSubview(lblUpVotes)
        downVote.frame = CGRect(x: viewWidth - 30, y: 0, width: 25, height: 25)
        downVote.setImage(AppIcons.ThumbDown, for: .normal)
        downVote.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        downVote.tintColor = UIColor.blueDark
        self.addSubview(downVote)
        lblDownVotes.frame = CGRect(x: viewWidth - 5, y: 0, width: 40, height: 25)
        lblDownVotes.text = "(" + String(downVoteCount) + ")"
        lblDownVotes.textColor = UIColor.blueDark
        lblDownVotes.font = UIFont.systemFont(ofSize: 12)
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
