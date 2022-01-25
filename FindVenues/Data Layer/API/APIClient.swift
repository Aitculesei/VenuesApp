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
//        httpClient.get(class: VenuesDTO.self, url: requestDTO.urlString, parameters: requestDTO.parametersDicitonary, headers: nil) { result in
//            switch result {
//            case .success(let receivedVenues):
//                completion(receivedVenues)
//            case .failure(let error):
//                print("APIClient: HTTPClient Error for venues: \(error.localizedDescription)")
//            }
//        }
        httpClient.getFromLocalFile(class: VenuesDTO.self, file: "FoodVenues") { result in
            switch result {
            case .success(let receivedVenues):
                completion(receivedVenues)
            case .failure(let error):
                print("APIClient: HTTPClient Error for venues: \(error.localizedDescription)")
            }
        }
    }
    
    func getCategories(requestDTO: CategoriesRequestDTO, completion: @escaping (CategoriesDTO) -> Void) {
//        httpClient.get(class: CategoriesDTO.self, url: requestDTO.urlString, parameters: requestDTO.parametersDicitonary, headers: nil) { result in
//            switch result {
//            case .success(let receivedCategories):
//                completion(receivedCategories)
//            case .failure(let error):
//                print("APIClient: HTTPClient Error for categories: \(error.localizedDescription)")
//            }
//        }
        httpClient.getFromLocalFile(class: CategoriesDTO.self, file: "Categories") { result in
            switch result {
            case .success(let receivedCategories):
                completion(receivedCategories)
            case .failure(let error):
                print("APIClient: HTTPClient Error for categories: \(error.localizedDescription)")
            }
        }
    }
    
    func getVenuePhoto(id: String, requestDTO: VenuePhotoRequestDTO, completion: @escaping (VenuePhotosDTO) -> Void) {
//        httpClient.get(class: VenuePhotosDTO.self, url: requestDTO.photoURLString, parameters: requestDTO.parametersDicitonary, headers: nil) { result in
//            switch result {
//            case .success(let receivedPhotos):
//                completion(receivedPhotos)
//            case .failure(let error):
//                print("HTTPClient Error for venues photos request: \(error)")
//            }
//        }
        httpClient.getFromLocalFile(class: VenuePhotosDTO.self, file: id) { result in
            switch result {
            case .success(let receivedPhotos):
                completion(receivedPhotos)
            case .failure(let error):
                print("HTTPClient Error for venues photos request: \(error)")
            }
        }
    }
}

