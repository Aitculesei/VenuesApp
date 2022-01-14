//
//  MyLocationMarkerView.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 14.01.2022.
//

import MapKit

class MyLocationMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let myLocation = newValue as? MyLocation else {
                return
            }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            markerTintColor = myLocation.markerTintColor
            if let letter = myLocation.title {
                glyphText = String(letter)
            }
        }
    }
}

