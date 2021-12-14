//
//  Repository.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import Foundation

struct Venue: Codable {
    let id: String
    let name: String
    let location: String
    init(venueDetailsAPIData: VenueAPI) {
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

struct Repository {
    
    func getVenueDetails(at completion: @escaping (Venue?) -> ()) {
        GetVenueDetailsAPI().getVenueDetails(from: C.Venue.details) { result in

            switch result {
            case .success(let receivedVenueDetails):
//                completion(receivedVenueDetails?.map({ vanueAPIDetail in
//                    Venue(venueDetailsAPIData: vanueAPIDetail.venue)
//                }))
                guard let receivedVenueDetailsData = receivedVenueDetails?.venue else {
                    return
                }
                completion(Venue(venueDetailsAPIData: receivedVenueDetailsData))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
