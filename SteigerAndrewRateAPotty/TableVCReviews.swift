//
//  ViewController.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 2/23/23.
//

import UIKit

class TableVCReviews: UITableViewController {
    @IBOutlet weak var lblHeader: UILabel!
    
    let maxResults: Int = 10
    var currentPotty: Potty?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if currentPotty == nil { return }
        //initialize locals
        lblHeader.text = "All " + String(currentPotty!.ratings.count) + " Reviews"
        self.tableView.reloadData()
    }
    
    override func tableView
    
    // MARK: - tableView-cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReviewCell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.reuseIdentifier, for: indexPath) as! ReviewCell
        if currentPotty == nil { return cell }
        if (indexPath.row == 0) {
            cell.lblReviewTitle.text = "Top Rated Review: " + "\(currentPotty!.ratings[indexPath.row].author)"
        }
        else {
            cell.lblReviewTitle.text = "\(currentPotty!.ratings[indexPath.row].author)"
        }
        cell.lblReviewComment.text = "\"" + (currentPotty!.ratings[indexPath.row].comment) + "\""
        cell.viewRatingStars.setRating((currentPotty!.ratings[indexPath.row].ratingAtmosphere + currentPotty!.ratings[indexPath.row].ratingCleanliness + currentPotty!.ratings[indexPath.row].ratingAccessibility) / 3)
        cell.viewRatingStars.disable(true)
        cell.viewRatingReviewSupport.setUpVotes(currentPotty!.ratings[indexPath.row].upVotes)
        cell.viewRatingReviewSupport.setDownVotes(currentPotty!.ratings[indexPath.row].downVotes)
        cell.viewRatingReviewSupport.currentReview = currentPotty!.ratings[indexPath.row]
        cell.viewRatingReviewSupport.setUserVote()
        
        //store the index in the tag to access with button clicks
        cell.btnReadFullReview.tag = Int(indexPath.row)
        
        //set width of border based on tablveView, because swift isn't intuitively setting
        //it's child cell width correctly.
        let parentBoundBorder = UIView(frame: CGRect(x: cell.layoutView.frame.minX, y: cell.layoutView.frame.minY, width: tableView.frame.width, height: cell.layoutView.frame.height))
        cell.layoutView.layer.addSublayer(DrawBorderLayer(parentBoundBorder, inset: 14))
        return cell
    }
    
    // MARK: - tableView - numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentPotty == nil { return 0 }
        return currentPotty!.ratings.count
    }
    
    // MARK: - btnReadFullReviewTap()
    /// Define the actions when stars inside of `RatingStars` are clicked.
    ///
    /// Checking one star will automatically check the others below it to retain a sequential selection.
    ///
    /// Unchecking one star will automatically uncheck the others above it to retain a sequential selection.
    ///
    /// - Parameters:
    ///   - sender: The star button that was selected
    @IBAction func btnReadFullReviewTap(_ sender: UIButton) {
        if currentPotty == nil { return }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReviewDetailViewController") as! ReviewDetailViewController
        vc.currentReview = currentPotty!.ratings[sender.tag]
        if let navigationController = self.navigationController {
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
