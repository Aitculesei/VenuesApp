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

class VenueRepository: VenueRepositoryProtocol {
    let apiClient: APIClientProtocol = APIClient()
    
    func getVenues(completion: @escaping ([VenueBO]?) -> Void) {
        apiClient.getVenues { response in
            completion(response.venues.map({ apiVenueResult in
                VenueBO(venueDetailsAPIData: apiVenueResult)
            }))
        }
    }
}
