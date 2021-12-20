//
//  Constants.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 14.12.2021.
//

import Foundation

struct Constants {
    enum Venue {
        static let details = "https://api.foursquare.com/v2/venues/1/"
        static let search = "https://api.foursquare.com/v2/venues/search"
//        static let search = ""
    }
    
    enum VenueSearchURL {
        static let scheme = "https"
        static let host = "api.foursquare.com"
        static let path = "/v2/venues/search"
    }
}
