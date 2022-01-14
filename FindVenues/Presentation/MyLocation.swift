//
//  MyLocation.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 11.01.2022.
//

import MapKit

class MyLocation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
    
    var markerTintColor: UIColor  {
      switch title {
      case "ME":
        return .blue
      default:
        return .cyan
      }
    }
}
