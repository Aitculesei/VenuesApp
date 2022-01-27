//
//  DetailsViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import UIKit

class VenuesViewController: UIViewController {
    var venuesTableView = UITableView()
    let venueDetailsView = VenueDetailsViewController()
    
    var receivedVenues: [VenueDetailsBO] = [] {
        didSet {
            self.venuesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        venuesTableView.backgroundColor = .white
        venuesTableView.delegate = self
        venuesTableView.dataSource = self
        venuesTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.TableViewCell.identifier)
        
        view.addSubview(venuesTableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        venuesTableView.frame = view.bounds
    }
}

// MARK: - Extensions

// Delegate is used to handle interactions of cells
extension VenuesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.venueDetailsView.receivedVenue = receivedVenues[indexPath.row]
        self.show(self.venueDetailsView, sender: self)
    }
}

extension VenuesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receivedVenues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCell.identifier, for: indexPath) as? UITableViewCell else {
            fatalError("Unable to determine Venues Table View Cell.")
        }
        
        cell.textLabel?.text = receivedVenues[indexPath.row].venueBO?.name
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
