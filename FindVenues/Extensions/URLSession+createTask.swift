//
//  URLSession+createTask.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import Foundation

enum HTTPErrors: Error {
    case badRequest
    case noData
    case badData
}

extension URLSession {
    static func createTask<DataType: Codable>(with url: String, completion: @escaping (Result<DataType?, HTTPErrors>) -> ()) -> URLSessionDataTask {
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            // HERE WE MAKE SURE THAT WE GET SOME DATA BACK
            guard let data = data, error == nil else {
                print("Something went wrong in creating a data task.")
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }

            var dataResults: DataType?
            do {
                dataResults = try JSONDecoder().decode(DataType.self, from: data)
            }
            catch {
                print("Failed to convert data: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(.failure(.badData))
                }
            }

            guard let json = dataResults else {
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(json))
            }
        })
    }
    
    static func createTask<DataType: Codable>(with request: URLRequest, completion: @escaping (Result<DataType?, HTTPErrors>) -> ()) -> URLSessionDataTask {
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            // HERE WE MAKE SURE THAT WE GET SOME DATA BACK
            guard let data = data, error == nil else {
                print("Something went wrong in creating a data task.")
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }

            var dataResults: DataType?
            do {
                dataResults = try JSONDecoder().decode(DataType.self, from: data)
            }
            catch {
                print("Failed to convert data: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(.failure(.badData))
                }
            }

            guard let json = dataResults else {
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(json))
            }
        })
    }
}

