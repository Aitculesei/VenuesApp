//
//  ViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    let repo = VenueRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repo.getVenues { result in
            guard let res = result else {
                print("Result was nil in the UIViewController!")
                return
            }
            for r in res {
                print("R: \(r.id), \(r.name), \(r.location).")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        createTabBarMenu()
    }
}

// MARK: - Extensions

extension TabBarViewController {
    func createTabBarMenu() {
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
        
        homeVC.drawMyMap()
        
        // Change tint color
        self.tabBar.tintColor = .black
        self.tabBar.backgroundColor = .white
    }
}
