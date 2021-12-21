//
//  Repository.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import Foundation

class VenueRepository: VenueRepositoryProtocol {
    let apiClient: APIClientProtocol = APIClient()
    
    func getVenues(completion: @escaping ([VenueBO]?) -> Void) {
        apiClient.getVenues { response in
            completion(response.results.map({ apiVenueResult in
                VenueBO(venueDetailsAPIData: apiVenueResult)
            }))
        }
    }
}
