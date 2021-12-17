//
//  ViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import UIKit
import MapKit
import CoreLocation

class TabBarViewController: UITabBarController {
    let repo = Repository()
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Constants.Venue.search)
        repo.getVenues { result in
            guard let res = result else {
                return
            }
            for r in res {
                print("\(r.id), \(r.name), \(r.location)")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        createTabBarMenu()
        determineMyCurrentLocation()
        drawMyMap()
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
        
        // Change tint color
        self.tabBar.tintColor = .black
        
        
    }
}

extension TabBarViewController: CLLocationManagerDelegate {
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
//        repo.setCurrentLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}

extension TabBarViewController: MKMapViewDelegate {
    func drawMyMap() {
        let mapView = MKMapView()
        
        let leftMargin:CGFloat = 10
        let topMargin:CGFloat = 60
        let mapWidth:CGFloat = view.frame.size.width-20
        let mapHeight:CGFloat = 300
        
        let screenSize = UIScreen.main.bounds
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
//        mapView.frame = screenSize
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        // Or, if needed, we can position map in the center of the view
        mapView.center = view.center
        
        view.addSubview(mapView)
    }
}
