//
//  VenueBO.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 21.12.2021.
//

struct VenueBO: Codable {
    let id: String?
    let name: String?
    let location: String?

    init(venueDetailsAPIData: VenueDTO) {
        self.id = venueDetailsAPIData.id
        self.name = venueDetailsAPIData.name
//        self.location = """
//        address: \(venueDetailsAPIData.location.address)
//        street: \(venueDetailsAPIData.location.crossStreet)
//        city: \(venueDetailsAPIData.location.city)
//        country: \(venueDetailsAPIData.location.country)
//        """
        self.location = "adress \(venueDetailsAPIData.location?.address ?? "") str \(venueDetailsAPIData.location?.crossStreet ?? "")"
    }
}
