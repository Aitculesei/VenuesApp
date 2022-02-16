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
        
        guard let currentLocation = HomeViewController.location else {
            fatalError("Current location is nil.")
        }
        
        let version = getCurrentDate()
        var requestDTO: VenuesRequestDTO
        requestDTO = VenuesRequestDTO(query: LocalDataManager.loadData(key: Constants.LocalDataManagerSavings.queryKey, type: String.self) ?? Constants.VenuesRequest.defaultQuery, lat: "\(String(describing: currentLocation.coordinate.latitude))", lng: "\(String(describing: currentLocation.coordinate.longitude))", version: version, radius: "\((LocalDataManager.loadData(key: Constants.LocalDataManagerSavings.rangeValueKey, type: Float.self) ?? 2) * 1000.0)")

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
    
    func getVenuePhotos(venueID: String, completion: @escaping (Result<[VenuePhotoDetailsBO], APIError>) -> Void) {
        let currentDate = getCurrentDate()
        let venuePhotoRequestDTO = VenuePhotoRequestDTO(venueID: venueID, version: currentDate)
        
        apiClient.getVenuePhoto(requestDTO: venuePhotoRequestDTO) { response in
            let rawData = response.response.venue.photos.groups[0].items
            completion(.success(rawData.map({ apiVenuePhotosRequestResult in
                VenuePhotoDetailsBO(venueID: response.response.venue.id, venueDetailsAPIData: apiVenuePhotosRequestResult)
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
