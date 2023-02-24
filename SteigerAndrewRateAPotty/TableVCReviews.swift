//
//  ViewController.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 2/23/23.
//

import UIKit

class TableVCReviews: UITableViewController {
    let appData = AppData()
    let maxResults: Int = 10
    var currentPotty: Potty = Potty(id: -1, latitude: 0.0, longitude: 0.0, ratings: []);

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentPotty = appData.getPottyByID(0)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath)

        cell.textLabel?.text = "\(currentPotty.ratings[indexPath.row].author) Row \(indexPath.row)"

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(currentPotty.ratings.count, maxResults)
    }
}

class TableViewCellReview: UITableViewCell {
    
}
