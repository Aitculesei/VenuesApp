//
//  HomeViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {
    internal var venuesMapView: MKMapView!
    private var homeViewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        homeViewModel = HomeViewModel()
        drawMyMap()
        setupConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        venuesMapView.removeAnnotations(venuesMapView.annotations)
    }
    
    func drawMyMap() {
        venuesMapView = homeViewModel.getMapView()
        venuesMapView.delegate = self
        
        view.addSubview(venuesMapView)
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
        
        for venue in homeViewModel.venues {
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
