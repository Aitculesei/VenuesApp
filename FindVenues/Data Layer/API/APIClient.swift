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
//<<<<<<< HEAD

    func getVenues(requestDTO: VenuesRequestDTO, completion: @escaping (VenuesDTO) -> Void) {
        httpClient.get(class: VenuesDTO.self, url: requestDTO.urlString, parameters: requestDTO.parametersDicitonary, headers: nil) { result in
//=======
//
//    // getVenues - PARAMETERS: lat, lng, category, radius, version (v=YYYYMMDD)
//    func getVenues(completion: @escaping (VenuesDTO) -> Void) {
//        guard let lat = LocalDataManager.loadData(key: Constants.LocalDataManagerSavings.Coordiantes.latitudeKey, type: CLLocationDegrees.self) else {
//            fatalError("APIClient: Latitude coordinate is missing.")
//        }
//        guard let lng = LocalDataManager.loadData(key: Constants.LocalDataManagerSavings.Coordiantes.longitudeKey, type: CLLocationDegrees.self) else {
//            fatalError("APIClient: Longitude coordinate is missing.")
//        }
//        let venuesRequestDTO: VenuesRequestDTO
//        if let query = LocalDataManager.loadData(key: Constants.LocalDataManagerSavings.queryKey, type: String.self){
//            venuesRequestDTO = VenuesRequestDTO(query: query, lat: "\(String(describing: lat))", lng: "\(String(describing: lng))")
//            LocalDataManager.resetData()
//        } else {
//            venuesRequestDTO = VenuesRequestDTO(query: "restaurant", lat: "\(String(describing: lat))", lng: "\(String(describing: lng))")
//            LocalDataManager.resetData()
//        }
//
//        httpClient.get(class: VenuesDTO.self, url: venuesRequestDTO.urlString, parameters: venuesRequestDTO.parametersDicitonary, headers: nil) { result in
//>>>>>>> features/20.12.2021
            switch result {
            case .success(let receivedVenues):
                completion(receivedVenues)
            case .failure(let error):
                print("HTTPClient Error: \(error.localizedDescription)")
            }
        }
    }
}

