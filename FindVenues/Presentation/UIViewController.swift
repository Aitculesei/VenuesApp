//
//  ViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    private(set) var venuesVC: VenuesViewController!
    private(set) var rangeVC: RangeViewController!
    private(set) var homeVC: HomeViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        venuesVC = VenuesViewController()
        rangeVC = RangeViewController()
        homeVC = HomeViewController()
        createTabBarMenu()
    }
}
