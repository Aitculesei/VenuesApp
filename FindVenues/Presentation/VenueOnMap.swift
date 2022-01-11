//
//  VenueOnMap.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 11.01.2022.
//

import MapKit

class VenueOnMap: NSObject, MKAnnotation {
    let locationName: String?
    let coordinate: CLLocationCoordinate2D
    
    init(locationName: String?, coordinate: CLLocationCoordinate2D) {
        self.locationName = locationName
        self.coordinate = coordinate
    }
}
