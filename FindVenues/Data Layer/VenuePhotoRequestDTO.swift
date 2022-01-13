//
//  VenuePhotoRequestDTO.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.01.2022.
//

import Foundation

struct VenuePhotoRequestDTO {
    var venueID: String
    var version: String
    
    var photoURLString: String {
        "\(Constants.API.baseURL)\(Constants.API.apiVersion)/\(Constants.API.Paths.photos)\(self.venueID)/"
    }
    
    var parametersDicitonary: [String: String] {
        let parameters = [Constants.VenuesRequest.Parameters.v : version]
        
        return parameters
    }
    
    init(venueID: String, version: String) {
        self.venueID = venueID
        self.version = version
    }
}
