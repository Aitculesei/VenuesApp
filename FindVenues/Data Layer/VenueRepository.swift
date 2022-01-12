//
//  Repository.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import Foundation
import CoreLocation

class VenueRepository: VenueRepositoryProtocol {
    let apiClient: APIClientProtocol = APIClient()

    func getVenues(completion: @escaping (Result<[VenueBO], APIError>) -> Void) {
        guard let lat = LocationManagerClass.sharedLocation?.coordinate.latitude else {
            fatalError("APIClient: Latitude coordinate is missing.")
        }
        guard let lng = LocationManagerClass.sharedLocation?.coordinate.longitude else {
            fatalError("APIClient: Longitude coordinate is missing.")
        }
        let version = getCurrentDate()
        let requestDTO: VenuesRequestDTO
        if let query = LocalDataManager.loadData(key: Constants.LocalDataManagerSavings.queryKey, type: String.self){
            requestDTO = VenuesRequestDTO(query: query, lat: "\(String(describing: lat))", lng: "\(String(describing: lng))", version: version)
        } else {
            requestDTO = VenuesRequestDTO(query: Constants.VenuesRequest.defaultQuery, lat: "\(String(describing: lat))", lng: "\(String(describing: lng))", version: version)
            LocalDataManager.resetData()
        }

        apiClient.getVenues(requestDTO: requestDTO) { response in
            guard let rawVenues = response.response?.venues else {
                completion(.failure(.noData))
                return
            }
            completion(.success(rawVenues.map({ apiVenueResult in
                VenueBO(venueDetailsAPIData: apiVenueResult)
            })))
        }
    }
    
    func getCategories(completion: @escaping (Result<[CategoryBO], APIError>) -> Void) {
        let currentDate = getCurrentDate()
        let categoryRequestDTO = CategoriesRequestDTO(version: currentDate)
        
        apiClient.getCategories(requestDTO: categoryRequestDTO) { response in
            guard let rawCategories = response.response.categories else {
                completion(.failure(.noData))
                return
            }
            completion(.success(rawCategories.map({ apiVenuesCategoriesResult in
                CategoryBO(venueCategoriesData: apiVenuesCategoriesResult)
            })))
        }
    }
    
    func getCurrentDate() -> String {
        let currentDate = Date()
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyyMMdd"
        let currentDateFormatted = dateFormatterGet.string(from: currentDate)
        
        return currentDateFormatted
    }
}
