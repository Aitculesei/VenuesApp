//
//  CategoriesRequestDTO.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 04.01.2022.
//

import Foundation

struct CategoriesRequestDTO {
    var version: String
    
    var urlString: String {
        "\(Constants.API.baseURL)/\(Constants.API.apiVersion)/\(Constants.API.Paths.categories)"
    }
    
    var parametersDicitonary: [String: String] {
        let parameters = [Constants.VenuesRequest.Parameters.v : version]
        
        return parameters
    }
    
    init(version: String) {
        self.version = version
    }
}
