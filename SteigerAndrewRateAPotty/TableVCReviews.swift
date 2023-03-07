//
//  ViewController.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 2/23/23.
//

import UIKit

class TableVCReviews: UITableViewController {
    @IBOutlet weak var lblHeader: UILabel!
    
    var appData: AppData = AppData()
    let maxResults: Int = 10
    var currentPotty: Potty?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if currentPotty == nil { return }
        // initialize locals
        appData = AppData()
        lblHeader.text = "All " + String(currentPotty!.ratings.count) + " Reviews"
        lblHeader.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReviewCell = self.tableView.dequeueReusableCell(withIdentifier: ReviewCell.reuseIdentifier, for: indexPath) as! ReviewCell
        if currentPotty == nil { return cell }
        if (indexPath.row == 0) {
            cell.lblReviewTitle.text = "Top Rated Review: " + "\(currentPotty!.ratings[indexPath.row].author)"
        }
        else {
            cell.lblReviewTitle.text = "\(currentPotty!.ratings[indexPath.row].author)"
        }
        cell.lblReviewComment.text = "\"" + (currentPotty!.ratings[indexPath.row].comment) + "\""
        cell.setRating((currentPotty!.ratings[indexPath.row].ratingAtmosphere + currentPotty!.ratings[indexPath.row].ratingCleanliness + currentPotty!.ratings[indexPath.row].ratingAccessibility) / 3)
        cell.setUpVotes(currentPotty!.ratings[indexPath.row].upVotes)
        cell.setDownVotes(currentPotty!.ratings[indexPath.row].downVotes)

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if currentPotty == nil { return }
        if let reviewDetailViewContainer = segue.destination as? ReviewDetailViewController {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                reviewDetailViewContainer.currentReview = currentPotty!.ratings[indexPath.row]
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentPotty == nil { return 0 }
        return currentPotty!.ratings.count
    }
}
