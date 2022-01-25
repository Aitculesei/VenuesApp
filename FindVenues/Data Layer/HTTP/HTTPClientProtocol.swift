//
//  HTTPClientProtocol.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 16.12.2021.
//

import Foundation

protocol HTTPClientProtocol {
    func get<T: Codable>(class: T.Type, url: String, parameters: [AnyHashable: String], headers: [AnyHashable: String]?, completion: @escaping (Result<T, HTTPErrors>) -> Void)
    func getFromLocalFile<T: Codable>(class: T.Type, file: String, completion: @escaping (Result<T, HTTPErrors>) -> Void)
}
