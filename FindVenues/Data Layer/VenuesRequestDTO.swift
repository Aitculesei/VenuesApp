//
//  VenuesRequestDTO.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 21.12.2021.
//

import Foundation

struct VenuesRequestDTO {
    var query: String
    var ll: String
    
    var urlString: String {
        "\(Constants.API.baseURL)\(Constants.API.apiVersion)\(Constants.API.Paths.search)"
    }
    
    var parametersDicitonary: [String: String] {
        let parameters = ["query" : query, "ll" : ll]
        
        return parameters
    }
    
    init(query: String, lat: String, lng: String) {
        self.query = query
        self.ll = "\(lat),\(lng)"
    }
}
