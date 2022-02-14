//
//  LocationManager.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 23.12.2021.
//

import Foundation
import CoreLocation
import SwiftSpinner

class LocationManagerClass: NSObject, CLLocationManagerDelegate {
    static var isCurrentLocationON = false
    static let shared = LocationManagerClass()
    let locationManager = CLLocationManager()
    
    var completion: ((CLLocation) -> Void)?
    
    public func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
        self.completion = completion
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if CLLocationManager.locationServicesEnabled(){
            let status = manager.authorizationStatus
            switch status {
            case .notDetermined:
                print("Not determined")
                manager.requestWhenInUseAuthorization()
            case .restricted:
                print("Restricted")
                break
            case .denied:
                print("Denied")
                DispatchQueue.main.async {
                    SwiftSpinner.show("Request for location DENIED! App is closing.")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    exit(0)
                }
                
                break
            case .authorizedAlways:
                print("Authorized")
                manager.startUpdatingLocation()
            case .authorizedWhenInUse:
                print("Authorized when in use")
                manager.startUpdatingLocation()
            case .authorized:
                print("Authorized")
                manager.startUpdatingLocation()
            }
        } else {
            print("Location services are not enabled!")
            exit(0)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        completion?(location)
        locationManager.stopUpdatingLocation()
    }
}
