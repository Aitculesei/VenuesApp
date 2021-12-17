//
//  APIClientProtocol.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 16.12.2021.
//

protocol APIClientProtocol {
    func getVenues(parameters: [AnyHashable: String], headers: [AnyHashable: String]?, completion: @escaping (Response) -> Void)
}
