//
//  HomeViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import UIKit
import MapKit
import SwiftSpinner

class HomeViewController: UIViewController {
    private var venuesViewModel: VenuesMapViewModel!
    @IBOutlet weak var venuesMapView: MKMapView!
    
    private(set) var venues = [VenueBO]()
    private let location: CLLocation = {
        guard let location = LocationManagerClass.sharedLocation else {
            fatalError("Could not get coordinates.")
        }
        
        return location
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        venuesViewModel = VenuesMapViewModel()
        venuesMapView.mapType = MKMapType.standard
        venuesMapView.isZoomEnabled = true
        venuesMapView.isScrollEnabled = true
        
        venuesMapView.register(
          MyLocationMarkerView.self,
          forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        self.setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.venuesMapView.centerToLocation(self.location)
        venuesViewModel.sendAction(action: .loadData)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        venuesMapView.removeAnnotations(venuesMapView.annotations)
    }
}

// MARK: - Extensions

extension HomeViewController: MKMapViewDelegate {
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
        
//        let launchOptions = [
//            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking
//        ]
//        venueOnMap.mapItem?.openInMaps(launchOptions: launchOptions)
        
        for venue in self.venues {
            if (venue.name! == venueOnMap.title!) {
                guard let venueID = venue.id else {
                    fatalError("Venue id found nil!")
                }
                
                let repo = VenueRepository()
                repo.getVenuePhotos(venueID: venueID) { result in
                    let venueDetailsView = VenueDetailsViewController()
                    switch result {
                    case .success(let venuePhotos):
                        if venuePhotos.isEmpty {
                            venueDetailsView.receivedVenue = VenueDetailsBO(venueBO: venue, photo: nil)
                            self.show(venueDetailsView, sender: self)
                        } else {
                            venueDetailsView.receivedVenue = VenueDetailsBO(venueBO: venue, photo: venuePhotos[0].photo!)
                            self.show(venueDetailsView, sender: self)
                        }
                    case .failure(let error):
                        print("Thrown error when we received venue photos. \(error)")
                    }
                }
            }
        }
    }
}

extension HomeViewController {
    func pinLocationsOnMap() {
        for venue in self.venues {
            guard let lat = venue.lat, let lng = venue.long else {
                fatalError("Venue lat or lng is missing.")
            }
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            let venueOnMap = VenueOnMap(title: venue.name, locationName: venue.location, coordinate: coordinate)

            venuesMapView.addAnnotation(venueOnMap)
        }
        
        if LocationManagerClass.isCurrentLocationON {
            let myLocation = MyLocation(title: "I am here!", coordinate: self.location.coordinate)
            venuesMapView.addAnnotation(myLocation)
        }
    }
    
    private func setupBindings() {
        self.venuesViewModel.state.bind { state in
            switch state{
            case .idle:
                // Hide spinner
                DispatchQueue.main.async {
                    SwiftSpinner.hide()
                }
            case .loading:
                // Show spinner
                DispatchQueue.main.async {
                    SwiftSpinner.show("Loading the map...")
                    SwiftSpinner.show(delay: 3.0, title: "It's taking a little longer than expected...")
                }
            case .loaded(let data):
                self.venues = data
                self.pinLocationsOnMap()
                // hide spinner
                DispatchQueue.main.async {
                    SwiftSpinner.hide()
                }
                self.venuesViewModel.sendAction(action: .reset)
            case .error(let error):
                //show error
                DispatchQueue.main.async {
                    SwiftSpinner.show("Failed to load the map!", animated: false)
                }
                
                self.venuesViewModel.sendAction(action: .reset)
            }
        }
    }
}
