//
//  VenuesRequestDTO.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 21.12.2021.
//

import Foundation

struct VenuesRequestDTO {
    var query: String
    var nearby: String = "Cluj Napoca"
    var radius: String = "2000"
    var ll: String
    var categories: String = "" // comma separated list
    var version: String
    // TODO: init this always with Date() formatted to a String with "YYYYMMDD" format, it should be automatically be generated on every call
    
    var urlString: String {
        "\(Constants.API.baseURL)/\(Constants.API.apiVersion)/\(Constants.API.Paths.search)"
    }
    
    var parametersDicitonary: [String: String] {
        let parameters = [Constants.VenuesRequest.Parameters.query : query, Constants.VenuesRequest.Parameters.ll: ll, Constants.VenuesRequest.Parameters.nearby : nearby, Constants.VenuesRequest.Parameters.radius : radius, Constants.VenuesRequest.Parameters.v : version, Constants.VenuesRequest.Parameters.categoryId : categories]
        
        return parameters
    }

    // TODO: implement complete initializer
    init(query: String, lat: String, lng: String, version: String) {
        self.query = query
        self.ll = "\(lat),\(lng)"
        self.version = version
    }
}
