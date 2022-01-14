//
//  VenueDetailsBO.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 14.01.2022.
//

import SwiftUI

struct VenueDetailsBO: Codable {
    let venueBO: VenueBO?
    let photo: String?
    
    init(venueBO: VenueBO?, photo: String?) {
        self.venueBO = venueBO
        self.photo = photo
    }
}
