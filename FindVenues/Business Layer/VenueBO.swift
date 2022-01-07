//
//  VenueBO.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 21.12.2021.
//

import SwiftUI

struct VenueBO: Codable {
    let id: String?
    let name: String?
    let location: String?
    let distance: Int?
    let phone: String?
//    let photo: UIImage?
    
    
    init(venueDetailsAPIData: VenueData) {
        self.id = venueDetailsAPIData.id
        self.name = venueDetailsAPIData.name
        self.location = "\(venueDetailsAPIData.location?.address ?? "")"
        self.distance = venueDetailsAPIData.location?.distance
        self.phone = venueDetailsAPIData.contact?.phone
//        self.photo = nil
    }
    
}
