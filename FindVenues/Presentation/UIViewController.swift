//
//  ViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import UIKit
import SimpleCheckbox

class TabBarViewController: UITabBarController {
    let repo = VenueRepository()
    let venuesVC = VenuesViewController()
    let rangeVC = RangeViewController()
    let homeVC = HomeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTabBarMenu()
        getCategories()
        updateVenues { venues in
            if let receivedVen = self.getPhotos(venues){
                print("receivedVenues: \(receivedVen)")
                VenuesViewController.receivedVenues = receivedVen
            } else {
                VenuesViewController.receivedVenues = []
            }
        }
    }
}

// MARK: - Extensions

extension TabBarViewController {
    func createTabBarMenu() {
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
    
    func updateVenues(completion: @escaping ([VenueBO]) -> Void) {
        repo.getVenues { result in
            switch result {
            case .success(let venuesBO):
                for r in venuesBO {
                    print("R: \(r.id), \(r.name), \(r.location).")
                }
                self.homeVC.venues = venuesBO
                completion(venuesBO)
            case .failure(let error):
                print("Something is baaad with getting the venues \(error)")
            }
        }
    }
    
    func getCategories() {
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
                print("Categories got a problem \(error)")
            }
        }
    }
    
    func getPhotos(_ venues: [VenueBO]) -> [VenueDetailsBO]? {
        var venueDetails: [VenueDetailsBO]?
        for venue in venues {
            guard let venueID = venue.id else {
                fatalError("Venue id found nil!")
            }
        
            repo.getVenuePhotos(venueID: venueID) { result in
                switch result {
                case .success(let venuePhotos):
                    if venuePhotos.isEmpty {
                        venueDetails?.append(VenueDetailsBO(venueBO: venue, photo: nil))
                    } else {
                        venueDetails?.append(VenueDetailsBO(venueBO: venue, photo: venuePhotos[0].photo!))
                    }
                case .failure(let error):
                    print("Thrown error when we received venue photos. \(error)")
                }
            }
        }
        print("VenueDetails: \(venueDetails)")
        return venueDetails
    }
}

