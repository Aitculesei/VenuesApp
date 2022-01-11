//
//  MyLocation.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 11.01.2022.
//

import MapKit

class MyLocation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
