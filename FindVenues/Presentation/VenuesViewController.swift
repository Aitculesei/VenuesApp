//
//  DetailsViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import UIKit

class VenuesViewController: UIViewController {
    static var venuesTableView = UITableView()
    let venueDetailsView = VenueDetailsViewController()
    
    static var receivedVenues: [VenueDetailsBO] = [] {
        didSet {
            self.venuesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        VenuesViewController.venuesTableView.backgroundColor = .lightGray
        VenuesViewController.venuesTableView.delegate = self
        VenuesViewController.venuesTableView.dataSource = self
        VenuesViewController.venuesTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.TableViewCell.identifier)
        view.addSubview(VenuesViewController.venuesTableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        VenuesViewController.venuesTableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        VenuesViewController.venuesTableView.frame = view.bounds
    }
}

// MARK: - Extensions

// Delegate is used to handle interactions of cells
extension VenuesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.venueDetailsView.receivedVenue = VenuesViewController.receivedVenues[indexPath.row]
        show(venueDetailsView, sender: self)
    }
}

extension VenuesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VenuesViewController.receivedVenues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCell.identifier, for: indexPath) as? UITableViewCell else {
            fatalError("Unable to determine Venues Table View Cell.")
        }
        
        cell.textLabel?.text = VenuesViewController.receivedVenues[indexPath.row].venueBO?.name
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
