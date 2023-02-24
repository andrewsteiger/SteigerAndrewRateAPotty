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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ReviewCell")
        
        // initialize locals
        appData = AppData()
        currentPotty = appData.getPottyByID(0);
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath)

        cell.textLabel?.text = "\(currentPotty.ratings[indexPath.row].author) Row \(indexPath.row)"

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(currentPotty.ratings.count, maxResults)
    }
}

class TableViewCellReview: UITableViewCell {
    
}
