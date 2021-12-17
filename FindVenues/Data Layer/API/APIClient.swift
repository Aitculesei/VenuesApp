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
    func getVenues(parameters: [AnyHashable: String], headers: [AnyHashable: String]?, completion: @escaping (Response) -> Void) {
        httpClient.get(class: Response.self, url: Constants.Venue.search, parameters: parameters, headers: headers) { result in
            switch result {
            case .success(let receivedVenues):
                completion(receivedVenues)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
