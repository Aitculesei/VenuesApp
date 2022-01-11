//
//  HomeViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController {
    let mapView = MKMapView()
    var location = CLLocation()
    var venuesOnMap: [VenueOnMap] = []
    var locationManager: LocationManagerClass?
    var venues: [VenueBO] = [] {
        didSet {
            self.pinLocationsOnMap()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        guard let location = LocationManagerClass.sharedLocation else {
            fatalError("Could not get coordinates.")
        }
        self.location = location
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        TabBarViewController().reloadInputViews()
    }
    
    func pinLocationsOnMap() {
        for venue in venues {
            guard let lat = venue.lat, let lng = venue.long else {
                fatalError("Venue lat or lng is missing.")
            }
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            let venueOnMap = VenueOnMap(locationName: venue.name, coordinate: coordinate)
            
            venuesOnMap.append(venueOnMap)
        }
        drawMyMap()
    }
}

// MARK: - Extensions

extension HomeViewController: MKMapViewDelegate {
    func drawMyMap() {
        mapView.frame = view.bounds
        
        mapView.delegate = self
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
//        mapView.center = view.center
        mapView.centerToLocation(self.location)
        let myLocation = MyLocation(coordinate: self.location.coordinate)
        mapView.addAnnotation(myLocation)
        
        for venueOnMap in venuesOnMap {
            mapView.addAnnotation(venueOnMap)
        }
        
        view.addSubview(mapView)
    }
}
