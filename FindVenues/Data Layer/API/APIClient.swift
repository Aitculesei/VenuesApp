//
//  APIClient.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 16.12.2021.
//

import Foundation
import CoreLocation

class APIClient: APIClientProtocol {
    var httpClient: HTTPClientProtocol = HTTPClient()
    
    // getVenues - PARAMETERS: lat, lng, category, radius, version (v=YYYYMMDD)
    func getVenues(completion: @escaping (Response) -> Void) {
        httpClient.get(class: Welcome.self, url: Constants.Venue.search, parameters: ["query" : "bar", "ll" : "41.8781,-87.6298", "radius" : "2000", "v" : "20211220"], headers: nil) { result in
            switch result {
            case .success(let receivedVenues):
                completion(receivedVenues.response)
            case .failure(let error):
                print("HTTPClient Error: \(error.localizedDescription)")
            }
        }
    }
}
