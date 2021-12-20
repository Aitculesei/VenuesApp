//
//  VenueRepositoryProtocol.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 20.12.2021.
//

protocol VenueRepositoryProtocol {
    func getVenues(completion: @escaping ([VenueBO]?) -> Void)
}
