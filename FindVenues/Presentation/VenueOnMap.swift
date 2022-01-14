//
//  VenueOnMap.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 11.01.2022.
//

import MapKit
import Contacts

class VenueOnMap: NSObject, MKAnnotation {
    let title: String?
    let locationName: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, locationName: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
    }
    
    var subtitle: String? {
        locationName
    }
    
    // To tell the Maps where to go. MKMapItem = describes a point of interest on the map
    var mapItem: MKMapItem? {
      guard let location = locationName else {
        return nil
      }

      let addressDict = [CNPostalAddressStreetKey: location]
      let placemark = MKPlacemark(
        coordinate: coordinate,
        addressDictionary: addressDict)
      let mapItem = MKMapItem(placemark: placemark)
      mapItem.name = title
      return mapItem
    }
}
