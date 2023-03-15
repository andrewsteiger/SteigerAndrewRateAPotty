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
    private var isDisabled: Bool = false
    var voteCast: Bool?
    var currentReview: PottyReview?
    
    var apiClient = ApiClient()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - buttonAction()
    /// note this would be a lot prettier if a real api was here to handle increment/decrement tied with user data but i didnt want to make an ungodly large mock data structure that kept track of every vote and user data
    @objc func buttonAction(sender: UIButton!) {
        if isDisabled || currentReview == nil { return }
        // handle voting
        switch sender.tag {
            // sender is upVote
        case 1:
            // user had no vote, set to true
            if voteCast == nil {
                // increment upVote
                voteCast = true
                apiClient.postVote(currentReview!.id, increment: true, upVote: true, userCastVote: voteCast)
                upVoteCount += 1
                setUpVotes(upVoteCount)
                upVote.setImage(AppAssets.Icons.ThumbUpSelected, for: .normal)
            }
            // change from down vote to up vote
            else if voteCast == false {
                // decrement downVote
                apiClient.postVote(currentReview!.id, increment: false, upVote: false, userCastVote: voteCast)
                downVoteCount -= 1
                setDownVotes(downVoteCount)
                downVote.setImage(AppAssets.Icons.ThumbDown, for: .normal)
                // increment upVote
                voteCast = true
                apiClient.postVote(currentReview!.id, increment: true, upVote: true, userCastVote: voteCast)
                upVoteCount += 1
                setUpVotes(upVoteCount)
                upVote.setImage(AppAssets.Icons.ThumbUpSelected, for: .normal)
            }
            else {
                // user undid previous upvote, decrement upVote
                voteCast = nil
                apiClient.postVote(currentReview!.id, increment: false, upVote: true, userCastVote: voteCast)
                upVoteCount -= 1
                setUpVotes(upVoteCount)
                upVote.setImage(AppAssets.Icons.ThumbUp, for: .normal)
                return
            }
            //sender is downvote
        case 0:
            // user had no vote, set to false
            if voteCast == nil {
                // increment downVote
                voteCast = false
                apiClient.postVote(currentReview!.id, increment: true, upVote: false, userCastVote: voteCast)
                downVoteCount += 1
                setDownVotes(downVoteCount)
                downVote.setImage(AppAssets.Icons.ThumbDownSelected, for: .normal)
            }
            // change from up vote to down vote
            else if voteCast == true {
                // decrement upVote
                apiClient.postVote(currentReview!.id, increment: false, upVote: true, userCastVote: voteCast)
                upVoteCount -= 1
                setUpVotes(upVoteCount)
                upVote.setImage(AppAssets.Icons.ThumbUp, for: .normal)
                // increment downVote
                voteCast = false
                apiClient.postVote(currentReview!.id, increment: true, upVote: false, userCastVote: voteCast)
                downVoteCount += 1
                setDownVotes(downVoteCount)
                downVote.setImage(AppAssets.Icons.ThumbDownSelected, for: .normal)
            }
            else {
                // user undid previous downvote, decrement downVote
                voteCast = nil
                apiClient.postVote(currentReview!.id, increment: false, upVote: false, userCastVote: voteCast)
                downVoteCount -= 1
                setDownVotes(downVoteCount)
                downVote.setImage(AppAssets.Icons.ThumbDown, for: .normal)
                return
            }
        default:
            return
        }
    }
    
    // MARK: - disable()
    func disable(_ shouldDisable: Bool) {
        isDisabled = shouldDisable
    }
    
    // MARK: - Modify Votes
    ///set up vote count.  call externally in parent
    func setUpVotes(_ upVotes: Int) {
        upVoteCount = upVotes
        lblUpVotes.text = "(" + String(upVoteCount) + ")"
    }
    
    ///set down vote count.  call externally in parent
    func setDownVotes(_ downVotes: Int) {
        downVoteCount = downVotes
        lblDownVotes.text = "(" + String(downVoteCount) + ")"
    }
    
    ///set user previous vote.  call externally in parent
    func setUserVote() {
        if currentReview == nil { return }
        if let previousCast = apiClient.getUserCastedVote(currentReview!.id) {
            // update UI to reflect change
            switch previousCast {
            case true:
                voteCast = true
                apiClient.postVote(currentReview!.id, increment: true, upVote: true, userCastVote: voteCast)
                upVoteCount += 1
                setUpVotes(upVoteCount)
                upVote.setImage(AppAssets.Icons.ThumbUpSelected, for: .normal)
            case false:
                voteCast = false
                apiClient.postVote(currentReview!.id, increment: true, upVote: false, userCastVote: voteCast)
                downVoteCount += 1
                setDownVotes(downVoteCount)
                downVote.setImage(AppAssets.Icons.ThumbDownSelected, for: .normal)
            }
        }
        else {
            upVote.setImage(AppAssets.Icons.ThumbUp, for: .normal)
            downVote.setImage(AppAssets.Icons.ThumbDown, for: .normal)
        }
    }
    
    // MARK: - setupView()
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
        upVote.tag = 1
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
        downVote.tag = 0
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
}
