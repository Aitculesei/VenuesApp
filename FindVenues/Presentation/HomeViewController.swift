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
    let venuesMapView = MKMapView()
    var location = CLLocation()
    var locationManager: LocationManagerClass?
    var venues = [VenueBO]() {
        didSet {
            self.pinLocationsOnMap()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        venuesMapView.delegate = self
        venuesMapView.mapType = MKMapType.standard
        venuesMapView.isZoomEnabled = true
        venuesMapView.isScrollEnabled = true
        
        guard let location = LocationManagerClass.sharedLocation else {
            fatalError("Could not get coordinates.")
        }
        self.location = location
        
        venuesMapView.register(
          MyLocationMarkerView.self,
          forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        drawMyMap()
        setupConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let allAnnotations = venuesMapView.annotations
        venuesMapView.removeAnnotations(allAnnotations)
    }
    
    func pinLocationsOnMap() {
        for venue in venues {
            guard let lat = venue.lat, let lng = venue.long else {
                fatalError("Venue lat or lng is missing.")
            }
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            let venueOnMap = VenueOnMap(title: venue.name, locationName: venue.location, coordinate: coordinate)
            
            venuesMapView.addAnnotation(venueOnMap)
        }
    }
}

// MARK: - Extensions

extension HomeViewController: MKMapViewDelegate {
    func drawMyMap() {
        
        venuesMapView.centerToLocation(self.location)
        
        self.pinLocationsOnMap()
        
        if LocationManagerClass.isCurrentLocationON {
            let myLocation = MyLocation(title: "I am here!", coordinate: self.location.coordinate)
            venuesMapView.addAnnotation(myLocation)
        }
        
        view.addSubview(venuesMapView)
    }
    
//    func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
//        print("VENUES IN MAP: \(venues)")
//    }
    
//    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
//        mapView.setCenter(userLocation.coordinate, animated: true)
//    }
    
    // Applied for each added annotation. Configures the CALLOUT
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? VenueOnMap else {
            return nil
        }
        
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(
            withIdentifier: Constants.MapView.identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            
            view = MKMarkerAnnotationView(
                annotation: annotation,
                reuseIdentifier: Constants.MapView.identifier)
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
