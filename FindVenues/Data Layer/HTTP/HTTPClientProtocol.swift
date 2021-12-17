//
//  HTTPClientProtocol.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 16.12.2021.
//

protocol HTTPClientProtocol {
    func get<T: Codable>(class: T.Type, url: String, parameters: [AnyHashable: String], headers: [AnyHashable: String]?, completion: @escaping (Result<T, HTTPErrors>) -> Void)
}
