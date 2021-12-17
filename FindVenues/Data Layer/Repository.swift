//
//  Repository.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import Foundation
import CoreLocation

struct VenueBO: Codable {
    let id: String
    let name: String
    let location: String
    init(venueDetailsAPIData: VenueDTO) {
        self.id = venueDetailsAPIData.id
        self.name = venueDetailsAPIData.name
        self.location = """
        address: \(venueDetailsAPIData.location.address)
        street: \(venueDetailsAPIData.location.crossStreet)
        city: \(venueDetailsAPIData.location.city)
        country: \(venueDetailsAPIData.location.country)
        """
    }
}

class Repository {
    let apiClient = APIClient()
    
    func getVenues(completion: @escaping ([VenueBO]?) -> Void) {
        apiClient.getVenues(parameters: ["query": "food", "ll":"41.8781%2C-87.6298", "radius":"2000", "v":"20211217"], headers: nil) { response in
            completion(response.venues.map({ apiVenueResult in
                VenueBO(venueDetailsAPIData: apiVenueResult)
            }))
        }
    }
    
}
