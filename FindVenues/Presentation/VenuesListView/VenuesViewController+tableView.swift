//
//  VenuesViewController+tableView.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 02.02.2022.
//

import Foundation
import UIKit

// Delegate is used to handle interactions of cells
extension VenuesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.showDetails(data: self.receivedVenues[indexPath.row])
    }
}

extension VenuesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.receivedVenues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCell.identifier, for: indexPath) as? UITableViewCell else {
            fatalError("Unable to determine Venues Table View Cell.")
        }
        
        cell.textLabel?.text = self.receivedVenues[indexPath.row].venueBO?.name
        cell.detailTextLabel?.text = self.receivedVenues[indexPath.row].venueBO?.location
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
