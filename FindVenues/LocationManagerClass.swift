//
//  LocationManager.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 23.12.2021.
//

import Foundation
import CoreLocation
import UIKit

class LocationManagerClass: NSObject, CLLocationManagerDelegate {
    let location: CLLocation
    static var isCurrentLocationON: Bool = false
    static var locationManager: CLLocationManager!
    
    static let sharedLocation: CLLocation? = {
        locationManager = CLLocationManager()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if(CLLocationManager.locationServicesEnabled() && (CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
              CLLocationManager.authorizationStatus() == .authorizedAlways)) {
            locationManager.startUpdatingLocation()
            guard let location = locationManager.location else {
                fatalError("Location is nil.")
            }
            
            return location
        } else {
            return nil
        }
    }()
    
    init(_ location: CLLocation) {
        self.location = location
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Location Manager Error ->> \(error)")
    }
}
