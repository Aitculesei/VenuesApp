//
//  ViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    private var venuesVM: VenuesViewModel!
    
    var venuesVC: VenuesViewController!
    var rangeVC: RangeViewController!
    var homeVC: HomeViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        venuesVC = VenuesViewController()
        rangeVC = RangeViewController()
        homeVC = HomeViewController()
        createTabBarMenu()
        
        venuesVM = VenuesViewModel()
        
        venuesVM.getVenuesV { venues, venueWithPhoto in
            self.venuesVC.receivedVenues = venueWithPhoto
        }
        venuesVM.getCategories { categories in
            self.rangeVC.queriesDataSource = categories
        }
    }
}
