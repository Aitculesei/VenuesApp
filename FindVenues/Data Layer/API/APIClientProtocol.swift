//
//  APIClientProtocol.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 16.12.2021.
//

protocol APIClientProtocol {
    func getVenues(requestDTO: VenuesRequestDTO, completion: @escaping (VenuesDTO) -> Void)
}
