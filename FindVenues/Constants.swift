//
//  Constants.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 14.12.2021.
//

import Foundation

struct Constants {
    enum API {
        static let baseURL = "https://api.foursquare.com/"
        static let apiVersion = "v3"
        
        enum Paths {
            static let search = "/places/nearby"
        }
    }
    
    enum LocalDataManagerSavings {
        enum Coordiantes {
            static let latitudeKey = "locationLatitude"
            static let longitudeKey = "locationLongitude"
        }
        static let queryKey = "query"
    }
    
    enum TableViewCell {
        static let identifier = "venuesTableCell"
    }
    
    enum CollectionViewCell {
        static let identifier = "queriesCollectionCell"
    }
}
