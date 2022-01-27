//
//  APIClientProtocol.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 16.12.2021.
//

protocol APIClientProtocol {
    func getVenues(requestDTO: VenuesRequestDTO, completion: @escaping (VenuesDTO) -> Void)
    func getCategories(requestDTO: CategoriesRequestDTO, completion: @escaping (CategoriesDTO) -> Void)
    func getVenuePhoto(requestDTO: VenuePhotoRequestDTO, completion: @escaping (VenuePhotosDTO) -> Void)
}
