//
//  HomeViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import UIKit
import MapKit
import CoreLocation
import SimpleCheckbox

class HomeViewController: UIViewController {
    let mapView = MKMapView()
    var location = CLLocation()
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
        
        mapView.register(
          MyLocationMarkerView.self,
          forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        TabBarViewController().reloadInputViews()
        self.reloadInputViews()
        drawMyMap()
    }
    
    func pinLocationsOnMap() {
        for venue in venues {
            guard let lat = venue.lat, let lng = venue.long else {
                fatalError("Venue lat or lng is missing.")
            }
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            let venueOnMap = VenueOnMap(title: venue.name, locationName: venue.location, coordinate: coordinate)
            
            mapView.addAnnotation(venueOnMap)
        }
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
        
        mapView.centerToLocation(self.location)
        if LocationManagerClass.isCurrentLocationON {
            let myLocation = MyLocation(title: "ME",coordinate: self.location.coordinate)
            mapView.addAnnotation(myLocation)
        }
        
        view.addSubview(mapView)
    }
    
    // Applied for each added annotation. Configures the CALLOUT
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? VenueOnMap else {
            return nil
        }
        
        let identifier = "venueOnMap"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(
            withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            
            view = MKMarkerAnnotationView(
                annotation: annotation,
                reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    // Tells what the CALLOUT should do
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let venueOnMap = view.annotation as? VenueOnMap else {
            return
          }

          let launchOptions = [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking
          ]
          venueOnMap.mapItem?.openInMaps(launchOptions: launchOptions)
    }
}


