//
//  APIClient.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 16.12.2021.
//

import Foundation
import CoreLocation

enum APIError: Error {
    case badRequest
    case noData
    case badData
}

class APIClient: APIClientProtocol {
    var httpClient: HTTPClientProtocol = HTTPClient()

    func getVenues(requestDTO: VenuesRequestDTO, completion: @escaping (VenuesDTO) -> Void) {
        httpClient.get(class: VenuesDTO.self, url: requestDTO.urlString, parameters: requestDTO.parametersDicitonary, headers: nil) { result in
            switch result {
            case .success(let receivedVenues):
                completion(receivedVenues)
            case .failure(let error):
                print("HTTPClient Error: \(error.localizedDescription)")
            }
        }
    }
}

