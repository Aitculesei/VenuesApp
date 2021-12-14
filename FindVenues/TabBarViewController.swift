//
//  ViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    let repo = Repository()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Tab bar is more like a collection of VC => Setup/Create instances of view controllers
        let homeVC = HomeViewController()
        let rangeVC = RangeViewController()
        let detailsVC = DetailsViewController()
        
        homeVC.title = "Home"
        rangeVC.title = "Distance"
        detailsVC.title = "Details"
        
        // Assign VC to Tab bar controller
        self.setViewControllers([homeVC, rangeVC, detailsVC], animated: false)
        
        guard let items = self.tabBar.items else {return}
        let images = ["house", "slider.horizontal.3", "list.bullet.rectangle.portrait.fill"]
        for (index, item) in items.enumerated() {
            item.image = UIImage(systemName: images[index])
        }
        
        // Change tint color
        self.tabBar.tintColor = .black
        
        repo.getVenueDetails { venueData in
            guard let venue = venueData else {
                return
            }
            
//            for venue in data {
            print("""
            DATA
            id: \(venue.id)
            name: \(venue.name)
            location: \(venue.location)
            """)
//            }
        }
    }
}
