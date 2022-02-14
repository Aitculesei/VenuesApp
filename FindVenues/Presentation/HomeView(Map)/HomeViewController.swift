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
    private var venuesViewModel: VenuesViewModel!
    @IBOutlet weak var venuesMapView: MKMapView!
    
    private var venueAnnotationImage = UIImageView()
    private(set) var venues = [VenueDetailsBO]()
    
    static var location: CLLocation!
    
    convenience init(_ currentLocation: CLLocation) {
        self.init(nibName:nil, bundle:nil)
        
        HomeViewController.location = currentLocation
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        venuesViewModel = VenuesViewModel()
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
        
        self.venuesMapView.centerToLocation(HomeViewController.location)
        self.venuesViewModel.sendAction(action: .loadData)
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
            
//            view.image = annotation.image.image
            print("IMAGE = \(annotation.image.image)")
            view.glyphImage = annotation.image.image
            view.clusteringIdentifier = Constants.MapView.identifier
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
            if (venue.venueBO?.name! == venueOnMap.title!) {
                let venueDetailsView = VenueDetailsViewController(venue)
                self.show(venueDetailsView, sender: self)
            }
        }
    }
}

extension HomeViewController {
    func pinLocationsOnMap() {
        for venue in self.venues {
            guard let lat = venue.venueBO?.lat, let lng = venue.venueBO?.long else {
                fatalError("Venue lat or lng is missing.")
            }
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            
            let venueOnMap = VenueOnMap(title: venue.venueBO?.name, locationName: venue.venueBO?.location, coordinate: coordinate, image:  venueAnnotationImage)
            
//            venuesViewModel.sendAction(action: .getAnnotationImage(link: venue.photo!))

            venuesMapView.addAnnotation(venueOnMap)
        }
        
        if LocationManagerClass.isCurrentLocationON {
            let myLocation = MyLocation(title: "I am here!", coordinate: HomeViewController.location.coordinate)
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
//            case .venueImageLoaded(let image):
//                print("IMAGE in the bind = \(image)")
//                self.venueAnnotationImage.image = image
//                // hide spinner
//                DispatchQueue.main.async {
//                    SwiftSpinner.hide()
//                }
//                self.venuesViewModel.sendAction(action: .reset)
            
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
