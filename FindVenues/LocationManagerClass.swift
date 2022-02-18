//
//  LocationManager.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 23.12.2021.
//

import Foundation
import CoreLocation
import SwiftSpinner
import UIKit

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
                    SwiftSpinner.show("Request for location DENIED! We need to get your location to be able to continue.")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.showPermissionAlert()
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
    
    func showPermissionAlert() {
        let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
            //Redirect to Settings app
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(cAlertAction) in
            //Redirect to Settings app
            DispatchQueue.main.async {
                SwiftSpinner.show("App is closing...")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                exit(0)
            }
        })
        alertController.addAction(cancelAction)

        alertController.addAction(okAction)

        var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        topController.present(alertController, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        completion?(location)
        locationManager.stopUpdatingLocation()
    }
}
