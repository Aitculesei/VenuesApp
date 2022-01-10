//
//  ViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    let repo = VenueRepository()
    let venuesVC = VenuesViewController()
    let rangeVC = RangeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTabBarMenu()
        repo.getVenues { result in
            switch result {
            case .success(let venuesBO):
                for r in venuesBO {
                    print("R: \(r.id), \(r.name), \(r.location).")
                }
                VenuesViewController.receivedVenues = venuesBO
            case .failure(let error):
                print("Something is baaad \(error.localizedDescription)")
            }
        }
        
        repo.getCategories { result in
            switch result {
            case .success(let categoriesBO):
                var categories: [String] = []
                for category in categoriesBO {
                    print("C: \(category.name)")
                    guard let name = category.name else {
                        fatalError("One category name is missing for some reason!")
                    }
                    categories.append(name)
                }
                self.rangeVC.queriesDataSource = categoriesBO
            case .failure(let error):
                print("Categories got a problem \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - Extensions

extension TabBarViewController {
    func createTabBarMenu() {
        let homeVC = HomeViewController()
        
        homeVC.title = "Home"
        rangeVC.title = "Distance"
        venuesVC.title = "Venues"
        
        // Assign VC to Tab bar controller
        self.setViewControllers([homeVC, rangeVC, venuesVC], animated: false)
        
        guard let items = self.tabBar.items else {return}
        let images = ["house", "slider.horizontal.3", "list.bullet.rectangle.portrait.fill"]
        for (index, item) in items.enumerated() {
            item.image = UIImage(systemName: images[index])
        }
        
        // Change tint color
        self.tabBar.tintColor = .black
        self.tabBar.backgroundColor = .white
    }
}
