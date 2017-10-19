//
//  ViewController.swift
//  USStatesApp
//
//  Created by vamsi krishna reddy kamjula on 10/19/17.
//  Copyright © 2017 kvkr. All rights reserved.
//

import UIKit
import CreatingFramework

let stateCellIdentifier = "stateCell"

class StatesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.instance.statesInfo(urlString: "http://services.groupkt.com/state/get/USA/all") { (success) in
            if success {
                self.tableView.reloadData()
            } else {
                // error handling
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.stateDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: stateCellIdentifier, for: indexPath) as? CustomTableCell {
            let stateDetails = DataService.instance.stateDetails[indexPath.row]
            cell.stateName.text = stateDetails.name
            cell.stateCapital.text = stateDetails.capital
            cell.stateArea.text = stateDetails.area
            cell.stateLargestCity.text = stateDetails.largestCity
            cell.stateAbbr.text = stateDetails.abbr
            cell.country.text = stateDetails.country
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

