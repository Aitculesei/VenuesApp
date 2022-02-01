//
//  HomeViewModel.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 01.02.2022.
//

import Foundation
import CoreLocation
import MapKit

class HomeViewModel: NSObject {
    private var venuesMapView: MKMapView!
    private var repo: VenueRepository!
    var venues = [VenueBO]() {
        didSet {
            self.pinLocationsOnMap()
        }
    }
    
    override init() {
        super.init()
        
        venuesMapView = MKMapView()
        repo = VenueRepository()
        repo.getVenues { result in
            switch result{
            case .success(let receivedVenues):
                self.venues = receivedVenues
            case .failure(let error):
                print("HomeViewModel: Error in getting the Venues: \(error)")
            }
            
        }
    }
    
    func getLocation() -> CLLocation {
        guard let location = LocationManagerClass.sharedLocation else {
            fatalError("Could not get coordinates.")
        }
        
        return location
    }
    
    func getMapView() -> MKMapView {
        venuesMapView.mapType = MKMapType.standard
        venuesMapView.isZoomEnabled = true
        venuesMapView.isScrollEnabled = true
        
        venuesMapView.register(
          MyLocationMarkerView.self,
          forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        venuesMapView.centerToLocation(self.getLocation())
        
        self.pinLocationsOnMap()
        
        return venuesMapView
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
        
        if LocationManagerClass.isCurrentLocationON {
            let myLocation = MyLocation(title: "I am here!", coordinate: self.getLocation().coordinate)
            venuesMapView.addAnnotation(myLocation)
        }
    }
}
