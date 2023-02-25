//
//  ViewController.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 2/23/23.
//

import UIKit

class TableVCReviews: UITableViewController {
    var appData: AppData = AppData()
    let maxResults: Int = 10
    var currentPotty: Potty = AppConfig.InitialStates.pottyInitialState;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize locals
        appData = AppData()
        currentPotty = appData.getPottyByID(0);
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReviewCell = self.tableView.dequeueReusableCell(withIdentifier: ReviewCell.reuseIdentifier, for: indexPath) as! ReviewCell
        cell.lblReviewTitle.text = "\(currentPotty.ratings[indexPath.row].author)"
        cell.lblReviewComment.text = "\t\"" + (currentPotty.ratings[indexPath.row].comment) + "\""

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(currentPotty.ratings.count, maxResults)
    }
}
