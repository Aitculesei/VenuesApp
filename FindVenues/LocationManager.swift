//
//  LocationManager.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 23.12.2021.
//

import Foundation
import CoreLocation

class LocationManager {
    let location: CLLocation
    static var locationManager: CLLocationManager?
    
    static let sharedLocation: CLLocation? = {
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.requestWhenInUseAuthorization()
//        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
        
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
              CLLocationManager.authorizationStatus() == .authorizedAlways) {
            guard let location = locationManager?.location else {
                fatalError("Location is nil.")
            }
            
            return location
        } else {
            return nil
        }
    }()
    
    private init(location: CLLocation) {
        self.location = location
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
