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
    var locationManager: CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        determineMyCurrentLocation()
        drawMyMap()
    }
}

// MARK: - Extensions

extension HomeViewController: CLLocationManagerDelegate {
    // TODO: Move this into a LocationManager singleton, that listens for location updates and has a variable of CLLocation with the most recent one that you can use where needed
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
        
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
              CLLocationManager.authorizationStatus() == .authorizedAlways) {
            guard let location = locationManager?.location else {
                fatalError("Location is nil.")
            }
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            LocalDataManager.saveData(data: latitude, key: Constants.LocalDataManagerSavings.Coordiantes.latitudeKey)
            LocalDataManager.saveData(data: longitude, key: Constants.LocalDataManagerSavings.Coordiantes.longitudeKey)
    
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Location Manager Error ->> \(error)")
    }
}

extension HomeViewController: MKMapViewDelegate {
    func drawMyMap() {
        mapView.frame = view.bounds
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        // Or, if needed, we can position map in the center of the view
        mapView.center = view.center
        
        view.addSubview(mapView)
    }
}
