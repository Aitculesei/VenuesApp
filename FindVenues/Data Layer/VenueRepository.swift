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

    // TODO: This should return a Result<[VenueBO], APIError> and get use plain parameters like query, nearby, location (a CLLocation) and categories
    func getVenues(completion: @escaping ([VenueBO]?) -> Void) {
        guard let lat = LocationManager.sharedLocation?.coordinate.latitude else {
            fatalError("APIClient: Latitude coordinate is missing.")
        }
        guard let lng = LocationManager.sharedLocation?.coordinate.longitude else {
            fatalError("APIClient: Longitude coordinate is missing.")
        }
        let version = getCurrentDate()
        let requestDTO: VenuesRequestDTO
        if let query = LocalDataManager.loadData(key: Constants.LocalDataManagerSavings.queryKey, type: String.self){
            requestDTO = VenuesRequestDTO(query: query, lat: "\(String(describing: lat))", lng: "\(String(describing: lng))", version: version)
            LocalDataManager.resetData()
        } else {
            requestDTO = VenuesRequestDTO(query: Constants.VenuesRequest.defaultQuery, lat: "\(String(describing: lat))", lng: "\(String(describing: lng))", version: version)
            LocalDataManager.resetData()
        }

        apiClient.getVenues(requestDTO: requestDTO) { response in
            guard let rawVenues = response.response?.venues else {
                completion(nil)
                return
            }
            completion(rawVenues.map({ apiVenueResult in
                VenueBO(venueDetailsAPIData: apiVenueResult)
            }))
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
