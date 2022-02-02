//
//  DetailsViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import UIKit

class VenuesViewController: UIViewController {
    private(set) var venuesListViewModel: VenuesListViewModel!
    private(set) var venuesTableView: UITableView!
    private(set) var venueDetailsView: VenueDetailsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        venuesListViewModel = VenuesListViewModel()
        venueDetailsView = VenueDetailsViewController()
        
        venuesTableView = venuesListViewModel.createTableView()
        venuesTableView.delegate = self
        venuesTableView.dataSource = self
        
        venuesTableView.reloadData()
        
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
