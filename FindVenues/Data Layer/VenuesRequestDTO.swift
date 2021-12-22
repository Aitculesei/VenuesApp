//
//  VenuesRequestDTO.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 21.12.2021.
//

import Foundation

struct VenuesRequestDTO {
    var query: String = "restaurant"
    var nearby: String = "Cluj Napoca"
    var radius: String = "2000"
    var ll: String = "46.770439,23.591423"
    var categories: String = "" // comma separated list

    // TODO: init this always with Date() formatted to a String with "YYYYMMDD" format, it should be automatically be generated on every call
    let version = "20211222"
    
    var urlString: String {
        "\(Constants.API.baseURL)/\(Constants.API.apiVersion)/\(Constants.API.Paths.search)"
    }
    
    var parametersDicitonary: [String: String] {
        // TODO: Move keys to Constants and use them from there
        let parameters = ["query" : query, "ll": ll, "nearby" : nearby, "radius": radius, "v": version, "categoryId": categories]
        
        return parameters
    }

    // TODO: implement complete initializer
//    init(query: String, lat: String, lng: String) {
//        self.query = query
//        self.ll = "\(lat),\(lng)"
//    }
}
