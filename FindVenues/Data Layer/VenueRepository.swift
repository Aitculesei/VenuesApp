//
//  Repository.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import Foundation

class VenueRepository: VenueRepositoryProtocol {
    let apiClient: APIClientProtocol = APIClient()

    // TODO: This should return a Result<[VenueBO], APIError> and get use plain parameters like query, nearby, location (a CLLocation) and categories
    func getVenues(completion: @escaping ([VenueBO]?) -> Void) {
        // TODO: Transfer the above parameters into the request object
        let requestDTO = VenuesRequestDTO()

        apiClient.getVenues(requestDTO: requestDTO) { response in
            guard let rawVenues = response.response?.venues else {
                completion(nil)
                return
            }
            completion(rawVenues.map({ apiVenueResult in
                VenueBO(venueDetailsAPIData: apiVenueResult)
            }))
        }
    }
}
