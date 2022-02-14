//
//  DetailsViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import UIKit
import SwiftSpinner

class VenuesViewController: UIViewController {
    private var venuesViewModel: VenuesViewModel!
    
    private(set) var venuesTableView: UITableView! = {
        let venuesTableView = UITableView()
        
        venuesTableView.backgroundColor = .white
        venuesTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.TableViewCell.identifier)
        
        return venuesTableView
    }()
    private(set) var receivedVenues: [VenueDetailsBO] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        venuesViewModel = VenuesViewModel()
        
        venuesTableView.delegate = self
        venuesTableView.dataSource = self
        
        view.addSubview(venuesTableView)

        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        venuesViewModel.sendAction(action: .loadData)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        venuesTableView.frame = view.bounds
    }
}

extension VenuesViewController {
    func setupBindings() {
        self.venuesViewModel.state.bind { state in
            switch state {
            case .idle:
                DispatchQueue.main.async {
                    SwiftSpinner.hide()
                }
            case .loading:
                DispatchQueue.main.async {
                    SwiftSpinner.show("Loading the venues...")
                    SwiftSpinner.show(delay: 3.0, title: "It's taking a little longer than expected...")
                }
            case .loaded(let venuesWithPhotos):
                self.receivedVenues = venuesWithPhotos
                self.venuesTableView.reloadData()
                DispatchQueue.main.async {
                    SwiftSpinner.hide()
                }
                self.venuesViewModel.sendAction(action: .reset)
//            case .venueImageLoaded(_):
//                DispatchQueue.main.async {
//                    SwiftSpinner.hide()
//                }
//                self.venuesViewModel.sendAction(action: .reset)
            case .error(let error):
                DispatchQueue.main.async {
                    SwiftSpinner.show("Failed to load the venues!", animated: false)
                }
                
                self.venuesViewModel.sendAction(action: .reset)
            }
            
        }
    }
}
