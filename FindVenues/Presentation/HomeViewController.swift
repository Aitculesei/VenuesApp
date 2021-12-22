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
    var locationManager: CLLocationManager!

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
//        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        if let location = locations.first {
            print("I WAS HERE!")
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            LocalDataManager.saveData(data: latitude, key: Constants.LocalDataManagerSavings.Coordiantes.latitudeKey)
            LocalDataManager.saveData(data: longitude, key: Constants.LocalDataManagerSavings.Coordiantes.longitudeKey)
        }
        
//        let annotation = MKPointAnnotation()
//        annotation.title = "Title"
//        annotation.coordinate = CLLocationCoordinate2D(latitude: locValue.latitude , longitude: locValue.longitude )
//        mapView.addAnnotation(annotation)
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
